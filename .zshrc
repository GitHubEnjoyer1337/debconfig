# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # You can change this to any theme you like

# Oh My Zsh plugins
plugins=(git colored-man-pages command-not-found)

source $ZSH/oh-my-zsh.sh

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# custom prompt
PROMPT='%F{blue}%n%f %F{green}${PWD##*/}%f $(git_prompt_info)'


# Aliases
alias l="ls -lah --color=auto"
alias brave="nohup brave-browser & disown"
alias shutdown="sudo shutdown -h now"
alias chrome="nohup chromium & disown"
alias writer="libreoffice --writer"
alias calc="libreoffice --calc"
alias impress="libreoffice --impress"
alias draw="libreoffice --draw"
alias base="libreoffice --base"
alias pass="nohup keepassxc & disown"


# Source cargo (Rust environment)
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin:/usr/sbin"

# History configuration
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# SSH agent configuration
eval "$(ssh-agent -s)"
if [ -f "$HOME/github/ssh/githubenjoyer1337/github_masterkey" ]; then
    ssh-add "$HOME/github/ssh/githubenjoyer1337/github_masterkey"
fi
