#!/bin/sh

banner() {
    echo -e "clean" >> $HOME/.zshrc
    echo -e "echo '  _______      __                __     _______ _______ ___ ___ '" >> $HOME/.zshrc
    echo -e "echo ' |   _   .----|  .-----.--.--.--|  |   |   _   |   _   |   Y   |'" >> $HOME/.zshrc
    echo -e "echo ' |.  |___|  __|  |  _  |  |  |  _  |   |___|   |   |___|.  |   |'" >> $HOME/.zshrc
    echo -e "echo ' |.  |   |____|__|_____|_____|_____|    /  ___/|____   |.  _   |'" >> $HOME/.zshrc
    echo -e "echo ' |:  ┴   |                             |:  ┴  \|:  ┴   |:  |   |'" >> $HOME/.zshrc
    echo -e "echo ' |::.. . |                             |::.. . |::.. . |::.|:. |'" >> $HOME/.zshrc
    echo -e "echo ' \`-------’                             \`-------\`-------\`--- ---'" >> $HOME/.zshrc
    echo -e "echo '                                                                '" >> $HOME/.zshrc
    echo -e "echo ' Feature rich Google Cloud Shell with ZSH                       '" >> $HOME/.zshrc
    echo -e "echo '                                                                '" >> $HOME/.zshrc
    echo -e "echo ' Check for updates https://github.com/Andygol/gcloud-shell-zsh  '" >> $HOME/.zshrc
    echo -e "echo '                                                                '" >> $HOME/.zshrc
    echo -e "echo '                                                                '" >> $HOME/.zshrc
}

install_package() {
    local package_name=$1
    local package_version=$2

    if ! command -v $package_name &> /dev/null; then
        echo "Installing $package_name..."
        if [ -z "$package_version" ]; then
            sudo apt install -y $package_name
        else
            sudo apt install -y $package_name=$package_version
        fi
    fi
}

install_zsh () {
    install_package zsh
}

is_exist() {
    local file_name=$1
    [ -f "$file_name" ] || [ -h "$file_name" ] || echo "$file_name not exist"
    return $?
}

install_antigen() {
    is_exist $HOME/.antigen/antigen.zsh
    if [ $? -ne 0 ]; then
        echo "Installing antigen..."
        curl -L git.io/antigen > $HOME/.antigen/antigen.zsh
    fi
}

configure_zshrc() {
    is_exist $HOME/.zshrc
    if [ $? -ne 0 ]; then
        touch $HOME/.zshrc
        echo "Configuring zshrc..."

        banner

        echo -e \
"source \$HOME/.antigen/antigen.zsh \n\n\
# Load the oh-my-zsh's library. \n\
antigen use oh-my-zsh \n\n\
# Syntax highlighting bundle. \n\
antigen bundle zsh-users/zsh-syntax-highlighting \n\
antigen bundle zsh-users/zsh-autosuggestions \n\
antigen bundle zsh-users/zsh-aliases-lsd \n\n\
# Bundles from the default repo (robbyrussell's oh-my-zsh).\n\
antigen bundle git \n\
antigen bundle gh \n\
antigen bundle docker \n\
antigen bundle docker-compose \n\
antigen bundle kubectl \n\
antigen bundle kube-ps1 \n\
antigen bundle helm \n\
antigen bundle terraform \n\
antigen bundle flux \n\
antigen bundle pip \n\
antigen bundle npm \n\n\
# Load the theme. \n\
antigen theme robbyrussell \n\n\
# Tell Antigen that you're done. \n\
antigen apply \n\n\
PROMPT=\$PROMPT'\$(kube_ps1) ' " >> $HOME/.zshrc

    fi
}

change_shell() {
    if [ $(ps -p $$ -o comm=) != "zsh" ] && [ $SHELL != "/bin/zsh" ] || [ $SHELL != "/usr/bin/zsh" ]; then
        echo "Changing shell..."
        sudo chsh -s $(which zsh)
    fi
}

backup_zshrc() {
    is_exist $HOME/.zshrc
    if [ $? -ne 0 ]; then
        echo "Found ~/.zshrc, backing up to ~/.zshrc.pre-antigen"
        mv $HOME/.zshrc $HOME/.zshrc.pre-antigen
    fi
}

init_zsh() {
    if [ $(ps -p $$ -o comm=) = "bash" ]; then
        if [ ! -f "$HOME/.zshrc" ]
            if [ -f "$HOME/.bashrc" ]; then
                echo "Found ~/.bashrc, backing up to ~/.bashrc.pre-zsh"
                mv $HOME/.bashrc $HOME/.bashrc.pre-zsh

                echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Andygol/gcloud-shell-zsh/main/install.sh"' >> $HOME/.bashrc
            fi
            install_antigen
            configure_zshrc
        fi
        install_zsh
        $(grep /zsh$ /etc/shells | tail -1)
    fi
}

init_zsh 
