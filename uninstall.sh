#!/bin/sh

# Function to print messages in a consistent way
print_message() {
    echo -e "==> $1"
}

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    print_message "Zsh is not installed\nThere's nothing to do"
fi

# Backup and remove files and folders
print_message "Removing Antigen and Oh My Zsh..."
rm -rf ~/.antigen ~/.oh-my-zsh
rm -f ~/.zsh* ~/antigen.zsh

# Uninstall Zsh
print_message "Uninstalling Zsh..."
sudo apt remove --purge zsh -y

# Restore the previous version of the profile
if [ -f "$HOME/.profile.pre-zsh" ]; then
    print_message "Restoring previous version of the profile..."
    mv ~/.profile.pre-zsh ~/.profile
else
    print_message "No previous profile backup found."
fi

print_message "You have successfully removed Zsh and related configurations."

# Pause for user confirmation
read -p "Press Enter to continue..."
