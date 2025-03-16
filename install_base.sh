# Create Folders
mkdir ~/Development ~/Downloads ~/.config

# Move Configs
# Copy Configuration Files
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_DIR="$SCRIPT_DIR/nvim"
TMUX_DIR="$SCRIPT_DIR/tmux"
I3_DIR="$SCRIPT_DIR/i3"
I3STATUS_DIR="$SCRIPT_DIR/i3status"
mv "$NVIM_DIR" "$TMUX_DIR" "$I3_DIR" "$I3STATUS_DIR" ~/.config/

# Install Base Packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y git htop neovim tmux wget python3 python3-venv \
         openjdk-17-jdk nodejs npm zip fonts-powerline newsboat \
		 ca-certificates curl gnupg apt-transport-https

# Add Package Repositories
## Microsoft
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

## Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Additonal Packages
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
		docker-buildx-plugin docker-compose-plugin

# Install Go
version_go="1.23.6"
wget https://go.dev/dl/go${version_go}.linux-amd64.tar.gz -P ~/Downloads
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf ~/Downloads/go${version_go}.linux-amd64.tar.gz
rm ~/Downloads/go${version_go}.linux-amd64.tar.gz

# Install SBT
version_sbt="1.10.7"
wget https://github.com/sbt/sbt/releases/download/v${version_sbt}/sbt-${version_sbt}.tgz -P ~/Downloads
sudo rm -rf /usr/local/sbt
sudo tar -C /usr/local -xzf ~/Downloads/sbt-${version_sbt}.tgz
rm ~/Downloads/sbt-${version_sbt}.tgz

# Install Protobuffer
version_protoc="29.3"
sudo rm -rf /usr/local/protoc
wget https://github.com/protocolbuffers/protobuf/releases/download/v${version_protoc}/protoc-${version_protoc}-linux-x86_64.zip -P ~/Downloads/
sudo unzip ~/Downloads/protoc-${version_protoc}-linux-x86_64.zip -d /usr/local/protoc
rm ~/Downloads/protoc-${version_protoc}-linux-x86_64.zip

# Install Plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
nvim +PluginInstall +qall
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

# Create Python Development Environment
rm -rf ~/Development/python-dev
python3 -m venv ~/Development/python-dev
$HOME/Development/python-dev/bin/pip install --upgrade pip
$HOME/Development/python-dev/bin/pip install numpy scipy sympy pandas polars \
		fastapi[standard] langchain dash matplotlib seaborn pymongo \
		scikit-learn tensorflow Flask requests pynvim neovim \
		build pytest setuptools ipython[terminal]

# Configure Git
git config --global user.name "Name"
git config --global user.email "Email"
git config --global core.editor "nvim"
git config --global credential.useHttpPath true
