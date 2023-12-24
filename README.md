# Gcloud Shell ZSH

ZSH with Antigen (Oh My ZSH)

```sh
  _______      __                __     _______ _______ ___ ___ 
 |   _   .----|  .-----.--.--.--|  |   |   _   |   _   |   Y   |
 |.  |___|  __|  |  _  |  |  |  _  |   |___|   |   |___|.  |   |
 |.  |   |____|__|_____|_____|_____|    /  ___/|____   |.  _   |
 |:  ┴   |                             |:  ┴  \|:  ┴   |:  |   |
 |::.. . |                             |::.. . |::.. . |::.|:. |
 `-------’                             `-------`-------`--- ---
                                                                
 Feature rich Google Cloud Shell with ZSH                       
                                                                
 Check for updates https://github.com/Andygol/gcloud-shell-zsh  

 Use omz plugin enable <list of plugins> to add couple of them
```

## Install

1. Open default (bash) Google Cloud Shell
2. Copy, paste and run

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Andygol/gcloud-shell-zsh/main/install.sh)"
```

### Included plugins

#### 3rd party plugins installed via Antigen

- `zsh-users/zsh-syntax-highlighting`
- `zsh-users/zsh-autosuggestions`
- `zsh-users/zsh-aliases-lsd`

#### Oh My ZSH plugins

To install Oh My ZSH plugins, use the command provided below

```sh
omz plugin enable <list of plugins>
```

## Uninstall

- `rm -rf ~/.antigen ~/.oh-my-zsh`
- `rm -f ~/.zsh*`
- `sudo apt remove --purge zsh -y`
- `mv ~/.profile.pre-zsh ~/.profile`

To uninstall ZSH along with Oh My ZSH and Antigen, use the command provided below

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Andygol/gcloud-shell-zsh/main/uninstall.sh)"
```
