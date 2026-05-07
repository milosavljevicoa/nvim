local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  print("mason failed to load")
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  print("mason_lspconfig failed to load")
  return
end

mason.setup()
mason_lspconfig.setup()


vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    }
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  }
})

local map = vim.keymap.set

local function go_to_definition()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local encoding = clients[1] and clients[1].offset_encoding or 'utf-8'
  local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), encoding)
  vim.lsp.buf_request_all(0, 'textDocument/definition', params, function(results)
    local locations = {}
    for _, result in pairs(results) do
      if result.result then
        local locs = vim.islist(result.result) and result.result or { result.result }
        vim.list_extend(locations, locs)
      end
    end

    local non_node = vim.tbl_filter(function(loc)
      local uri = loc.uri or loc.targetUri or ''
      return not uri:find('node_modules', 1, true)
    end, locations)

    local final = #non_node > 0 and non_node or locations
    if #final == 0 then return end

    if #final == 1 then
      vim.lsp.util.show_document(final[1], 'utf-8', { focus = true })
    else
      vim.fn.setqflist({}, ' ', {
        title = 'LSP Definitions',
        items = vim.lsp.util.locations_to_items(final, 'utf-8'),
      })
      vim.cmd('copen')
    end
  end)
end

-- Walk up directory tree to find tsconfig.json with path aliases
local function ts_get_tsconfig(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == '' then return nil end
  local dir = vim.fn.fnamemodify(fname, ':h')
  while true do
    for _, name in ipairs({ 'tsconfig.json', 'tsconfig.base.json', 'jsconfig.json' }) do
      local path = dir .. '/' .. name
      if vim.fn.filereadable(path) == 1 then
        local ok, lines = pcall(vim.fn.readfile, path)
        if ok then
          local content = table.concat(lines, '\n')
          content = content:gsub('/%*.-%*/', ''):gsub('//[^\n]*', '')
          local ok2, parsed = pcall(vim.fn.json_decode, content)
          if ok2 and parsed then
            local co = parsed.compilerOptions or {}
            if co.paths then
              return { paths = co.paths, dir = dir, base_url = co.baseUrl }
            end
          end
        end
      end
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then break end
    dir = parent
  end
  return nil
end

-- Convert a relative import path to its tsconfig alias equivalent, or nil
local function ts_rel_to_alias(rel_path, buf_file, tsconfig)
  local buf_dir = vim.fn.fnamemodify(buf_file, ':h')
  local abs = vim.fn.resolve(buf_dir .. '/' .. rel_path)
  local abs_no_ext = abs:gsub('%.[jt]sx?$', '')

  -- TypeScript resolves path targets relative to baseUrl when they don't
  -- start with "./" or "../"; otherwise relative to the tsconfig directory.
  local base_dir = tsconfig.base_url
    and vim.fn.resolve(tsconfig.dir .. '/' .. tsconfig.base_url)
    or tsconfig.dir

  for alias_pat, targets in pairs(tsconfig.paths) do
    for _, target in ipairs(targets) do
      local target_root = (target:sub(1, 1) == '.') and tsconfig.dir or base_dir

      if alias_pat:sub(-1) == '*' and target:sub(-1) == '*' then
        -- Strip trailing '*' to get the prefix, then resolve
        local target_rel_prefix = target:sub(1, -2)
        local target_abs_prefix = vim.fn.resolve(target_root .. '/' .. target_rel_prefix)
        -- Ensure a trailing slash so prefix matching is directory-exact
        if target_abs_prefix:sub(-1) ~= '/' then
          target_abs_prefix = target_abs_prefix .. '/'
        end
        local alias_prefix = alias_pat:sub(1, -2)
        for _, cand in ipairs({ abs, abs_no_ext }) do
          if vim.startswith(cand, target_abs_prefix) then
            return alias_prefix .. cand:sub(#target_abs_prefix + 1)
          end
        end
      else
        local target_abs = vim.fn.resolve(target_root .. '/' .. target)
        local t_no_ext = target_abs:gsub('%.[jt]sx?$', '')
        for _, cand in ipairs({ abs, abs_no_ext }) do
          if cand == target_abs or cand == t_no_ext then
            return alias_pat
          end
        end
      end
    end
  end
  return nil
end

-- For each import code action with a relative path, inject an alias variant
local function ts_inject_alias_actions(actions, bufnr)
  local tsconfig = ts_get_tsconfig(bufnr)
  if not tsconfig then return actions end

  local buf_file = vim.api.nvim_buf_get_name(bufnr)
  local result = {}

  for _, item in ipairs(actions) do
    table.insert(result, item)
    local action = item.action
    if not (action.title and action.title:match('[Ii]mport')) then goto continue end

    local rel_path
    local function scan(edits)
      for _, edit in ipairs(edits or {}) do
        if edit.newText and not rel_path then
          local p = edit.newText:match("from%s+['\"]([^'\"]+)['\"]")
          if p and p:sub(1, 1) == '.' then rel_path = p end
        end
      end
    end
    if action.edit then
      if action.edit.documentChanges then
        for _, ch in ipairs(action.edit.documentChanges) do scan(ch.edits) end
      end
      if not rel_path and action.edit.changes then
        for _, edits in pairs(action.edit.changes) do scan(edits) end
      end
    end

    if rel_path then
      local alias = ts_rel_to_alias(rel_path, buf_file, tsconfig)
      if alias then
        local new_action = vim.deepcopy(action)
        new_action.title = action.title:gsub(vim.pesc(rel_path), alias)
        local function patch(edits)
          for _, edit in ipairs(edits or {}) do
            if edit.newText then
              edit.newText = edit.newText
                :gsub("'" .. vim.pesc(rel_path) .. "'", "'" .. alias .. "'")
                :gsub('"' .. vim.pesc(rel_path) .. '"', '"' .. alias .. '"')
            end
          end
        end
        if new_action.edit then
          if new_action.edit.documentChanges then
            for _, ch in ipairs(new_action.edit.documentChanges) do patch(ch.edits) end
          end
          if new_action.edit.changes then
            for _, edits in pairs(new_action.edit.changes) do patch(edits) end
          end
        end
        table.insert(result, { action = new_action, client_id = item.client_id })
      end
    end

    ::continue::
  end
  return result
end

local function code_action_with_aliases()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype
  local is_ts = vim.tbl_contains(
    { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }, ft)

  if not is_ts then
    vim.lsp.buf.code_action({ filter = function(a) return not a.disabled end })
    return
  end

  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/codeAction' })
  if #clients == 0 then return end

  local win = vim.api.nvim_get_current_win()
  local encoding = clients[1].offset_encoding or 'utf-8'
  local params = vim.lsp.util.make_range_params(win, encoding)

  local cursor_line = vim.api.nvim_win_get_cursor(win)[1] - 1
  local diags = vim.diagnostic.get(bufnr, { lnum = cursor_line })
  local lsp_diags = {}
  for _, d in ipairs(diags) do
    if d.user_data and d.user_data.lsp then
      table.insert(lsp_diags, d.user_data.lsp)
    end
  end
  params.context = { diagnostics = lsp_diags, triggerKind = 1 }

  vim.lsp.buf_request_all(bufnr, 'textDocument/codeAction', params, function(results)
    local raw = {}
    for client_id, res in pairs(results) do
      if not res.error and res.result then
        for _, action in ipairs(res.result) do
          if not action.disabled then
            table.insert(raw, { action = action, client_id = client_id })
          end
        end
      end
    end

    local actions = ts_inject_alias_actions(raw, bufnr)

    if #actions == 0 then
      vim.notify('No code actions available', vim.log.levels.INFO)
      return
    end

    vim.ui.select(actions, {
      prompt = 'Code Action',
      format_item = function(item) return item.action.title end,
    }, function(choice)
      if not choice then return end
      local client = vim.lsp.get_client_by_id(choice.client_id)
      if not client then return end
      local action = choice.action
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
      if action.command then
        local cmd = type(action.command) == 'string'
          and { command = action.command, arguments = {} }
          or action.command
        client.request('workspace/executeCommand', cmd, nil, bufnr)
      end
    end)
  end)
end

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gd', go_to_definition, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', 'GD', vim.lsp.buf.type_definition, opts)
  map({ 'i', 'n' }, '<c-l>', vim.lsp.buf.signature_help, opts)
  map({ 'v', 'n' }, '<leader>fr', function() vim.lsp.buf.format({ async = true }) end, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>ca", code_action_with_aliases, opts)
  map("n", "<leader>gl", vim.diagnostic.open_float, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "gj", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, opts)
  map("n", "gk", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global defaults applied to every server
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
  on_attach = function(client, bufnr)
    -- Semantic tokens are computed on every keystroke; treesitter covers
    -- syntax highlighting so we don't need them. This is the single biggest
    -- ts_ls speedup available in nvim.
    client.server_capabilities.semanticTokensProvider = nil
    on_attach(client, bufnr)
  end,
  init_options = {
    preferences = {
      allowIncompleteCompletions = true,        -- stream partial results
      includeCompletionsWithSnippetText = false, -- fewer completion items
      includeAutomaticOptionalChainCompletions = false,
      importModuleSpecifierPreference = 'relative',
    },
    -- Hard cap server memory to reduce GC pause frequency on large projects
    maxTsServerMemory = 4096,
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        parameterHints = { enable = true },
        typeHints = { enable = true },
        chainingHints = { enable = true },
        maxLength = 25,
      },
    }
  }
})

vim.lsp.enable({ 'lua_ls', 'ts_ls', 'cssls', 'rust_analyzer' })
