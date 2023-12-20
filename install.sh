#!/bin/bash

ANTIGEN=$HOME/.antigen

banner() {
    local RC_FILE=$1

    echo -e "clear\n" >> $RC_FILE
    echo -e "echo '  _______      __                __     _______ _______ ___ ___ '" >> $RC_FILE
    echo -e "echo ' |   _   .----|  .-----.--.--.--|  |   |   _   |   _   |   Y   |'" >> $RC_FILE
    echo -e "echo ' |.  |___|  __|  |  _  |  |  |  _  |   |___|   |   |___|.  |   |'" >> $RC_FILE
    echo -e "echo ' |.  |   |____|__|_____|_____|_____|    /  ___/|____   |.  _   |'" >> $RC_FILE
    echo -e "echo ' |:  ┴   |                             |:  ┴  \|:  ┴   |:  |   |'" >> $RC_FILE
    echo -e "echo ' |::.. . |                             |::.. . |::.. . |::.|:. |'" >> $RC_FILE
    echo -e "echo ' \`-------’                             \`-------\`-------\`--- ---’'" >> $RC_FILE
    echo -e "echo '                                                                '" >> $RC_FILE
    echo -e "echo ' Feature rich Google Cloud Shell with ZSH                       '" >> $RC_FILE
    echo -e "echo '                                                                '" >> $RC_FILE
    echo -e "echo ' Check for updates https://github.com/Andygol/gcloud-shell-zsh  '" >> $RC_FILE
    echo -e "echo '                                                                '" >> $RC_FILE
    echo -e "echo ' Use omz plugin enable <list of plugins> to add couple of them  '" >> $RC_FILE
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

is_exist() {
    local file_name=$1
    [ -f "$file_name" ] || [ -h "$file_name" ]
    return $?
}

install_antigen() {
    is_exist $ANTIGEN/antigen.zsh
    if [ $? -ne 0 ]; then
        echo "Installing antigen..."
        mkdir -p $ANTIGEN
        curl -L git.io/antigen > $ANTIGEN/antigen.zsh
    fi
}

install_omz() {
    is_exist $HOME/.oh-my-zsh/oh-my-zsh.sh
    if [ $? -ne 0 ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
}

configure_antigen() {
    is_exist $ANTIGEN/.antigen.sh
    if [ $? -ne 0 ]; then
        touch $ANTIGEN/.antigen.sh
        echo -e "Configuring .antigen.sh ...\n"

        echo -e \
"source $ANTIGEN/antigen.zsh \n\n\
\
# Syntax highlighting bundle. \n\
antigen bundle zsh-users/zsh-completions \n\
antigen bundle zsh-users/zsh-syntax-highlighting \n\
antigen bundle zsh-users/zsh-autosuggestions \n\
\
# Tell Antigen that you're done. \n\
antigen apply \n\n" >> $ANTIGEN/.antigen.sh

        banner "$ANTIGEN/.antigen.sh"

            fi
}

init_zsh() {
    
    echo -e "Install ZSH \n"
    install_package zsh
    
    if [ ! -f "$HOME/.zshrc" ]; then

        echo -e "~/.zshrc does not exist, it will be created... \n"

        if [ -f "$HOME/.bashrc" ] && [ -f "$HOME/.profile" ]; then

            echo "Backup ~/.profile"
            echo "Found ~/.bashrc and ~/.profile, backup ~/.profile to ~/.profile.pre-zsh"
            echo " "

            cp $HOME/.profile $HOME/.profile.pre-zsh
        
            echo -e "\n# Initializing zsh" >> $HOME/.profile
            echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Andygol/gcloud-shell-zsh/main/install.sh)"' >> $HOME/.profile
        fi

        echo -e "Antigen will be installed \n"
        install_antigen
        
        echo -e "Antigen is being configured \n"
        configure_antigen
        
        echo -e "Oh My ZSH will be installed \n"
        install_omz
        
        echo -e "Add Antigen to ~/.zshrc\n"
        sed -i '/source $ZSH\/oh-my-zsh.sh/a source $HOME\/.antigen\/.antigen.sh' ~/.zshrc 
    fi

    exec zsh
}

init_zsh 
