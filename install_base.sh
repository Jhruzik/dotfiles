# Create Folders
mkdir ~/Development ~/Downloads ~/.config

# Move Configs
# Copy Configuration Files
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mv $SCRIPT_DIR/config/* ~/.config/

# Install Base Packages
sudo dnf update -y
sudo dnf install -y git htop neovim tmux wget python3 python3-devel python3-pip \
        golang java-latest-openjdk nodejs npm docker-cli containerd docker-compose \
        protobuf zip newsboat dnf-plugins-core ca-certificates curl gnupg apt-transport-https
		
# Install SBT
sudo rm -f /etc/yum.repos.d/bintray-rpm.repo
curl -L https://www.scala-sbt.org/sbt-rpm.repo > sbt-rpm.repo
sudo mv sbt-rpm.repo /etc/yum.repos.d/
sudo dnf install sbt

# Install Plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
nvim +PluginInstall +qall
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

# Create Python Development Environment
rm -rf ~/Development/python-dev
python -m venv ~/Development/python-dev
$HOME/Development/python-dev/bin/pip install --upgrade pip
$HOME/Development/python-dev/bin/pip install numpy scipy sympy pandas polars \
		fastapi[standard] langchain dash matplotlib seaborn pymongo \
		scikit-learn Flask requests pynvim neovim \
		build pytest setuptools ipython[terminal]

# Install DuckDB
curl https://install.duckdb.org | sh
printf "\n\n" >> $HOME/.bashrc
echo "export PATH='/home/$USER/.duckdb/cli/latest':$PATH" >> $HOME/.bashrc
		
# Configure Git
read -p "Enter Name for Git: " NAMEGIT
read -p "Enter Email for Git: " EMAILGIT
git config --global user.name $NAMEGIT
git config --global user.email $EMAILGIT
git config --global core.editor "nvim"
git config --global credential.useHttpPath true

# Add Alias and Environment Variables to Profile
printf "\n\n" >> $HOME/.bashrc
cat $SCRIPT_DIR/alias.txt >> $HOME/.bashrc
