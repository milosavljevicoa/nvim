FROM ubuntu

RUN apt-get update
RUN apt-get update
RUN apt-get install -y curl python-dev python3-dev python3-pip git

# Install Neovim from source.
RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim &&  make install
RUN rm -rf /root/TMP

RUN apt-get -y install curl fzf ripgrep
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


