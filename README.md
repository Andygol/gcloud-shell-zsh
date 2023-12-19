# Gcloud Shell ZSH

ZSH with Antigen (Oh My ZSH)

```
  _______      __                __     _______ _______ ___ ___ 
 |   _   .----|  .-----.--.--.--|  |   |   _   |   _   |   Y   |
 |.  |___|  __|  |  _  |  |  |  _  |   |___|   |   |___|.  |   |
 |.  |   |____|__|_____|_____|_____|    /  ___/|____   |.  _   |
 |:  ┴   |                             |:  ┴  \|:  ┴   |:  |   |
 |::.. . |                             |::.. . |::.. . |::.|:. |
 `-------’                             `-------`-------`--- ---
                                                                
 Feature rich Google Cloud Shell with ZSH                       
                                                                
 Check for updates https://github.com/Andygol/gcloud-shell-zsh  
```

## Install

1. Open default (bash) Google Cloud Shell
2. Paste and run

```sh
curl -fsSL https://raw.githubusercontent.com/Andygol/gcloud-shell-zsh/main/install.sh | sh -c -
```

### Included plugins

#### 3rd party plugins installed via Antigen
- zsh-users/zsh-syntax-highlighting
- zsh-users/zsh-autosuggestions
- zsh-users/zsh-aliases-lsd

#### Oh My ZSH plugins
- git
- gh
- docker
- docker-compose
- kubectl
- kube-ps1
- helm
- terraform
- flux
- pip
- npm

## Uninstall

- `rm -rf ~/.antigen`
- `rm ~/.zsh*`
- `sudo apt remove --purge zsh`
- `mv ~/.bashrc.pre-zsh ~/.bashrc`
