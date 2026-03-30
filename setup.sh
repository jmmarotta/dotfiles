#!bin/zsh

# install xcode if not installed
xcode-select --install
# accept license
sudo xcodebuild -license accept

# install homebrew if not installed
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# link Brewfile to $HOME/Brewfile if not already linked
if [ ! -f $HOME/Brewfile ]; then
    ln -s $HOME/Brewfile $HOME/Brewfile
fi

brew bundle install

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# stow tools
# If ~/.config/mise/config.toml or ~/.local/bin/luarocks already exist as
# regular files, adopt those packages first with:
#   stow --adopt mise luarocks
# and then re-run stow for the remaining packages.
stow zsh tmux nvim mise luarocks

source $HOME/.zshrc

# install programming languages from the mise config file in ~/.config/mise/config.yaml
mise install

# install a dedicated LuaRocks build against Homebrew LuaJIT
install-luarocks-luajit

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# if file does not exist for .private_variables, create it
if [ ! -f $HOME/.private_variables ]; then
    echo "export ANTHROPIC_API_KEY=YOUR_API_KEY" > $HOME/.private_variables
    echo "export CLAUDE_API_KEY=\$(echo \$ANTHROPIC_API_KEY)" >> $HOME/.private_variables
    echo "export OPENAI_API_KEY=YOUR_API_KEY" >> $HOME/.private_variables
fi

echo "1. install docker desktop:"
echo "https://docs.docker.com/desktop/install"
echo ""
echo "2. set github ssh key:"
echo "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
echo ""
echo "3. setup aws and gcloud if needed"
echo "aws sso login"
echo "gcloud auth login"
