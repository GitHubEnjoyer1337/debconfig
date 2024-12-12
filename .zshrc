# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # You can change this to any theme you like

# Oh My Zsh plugins
plugins=(git colored-man-pages command-not-found)

source $ZSH/oh-my-zsh.sh

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

# Environment variables
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin"

# History configuration
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# Source cargo
source "$HOME/.cargo/env"

# Function to get git branch (though Oh My Zsh git plugin provides this already)
function parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Custom prompt (though you might prefer using Oh My Zsh themes)
PROMPT='%F{blue}%n@%m %F{green}%1~%F{yellow}$(parse_git_branch | sed "s/.*/ git:(&)/")%f $ '

# SSH agent configuration
eval "$(ssh-agent -s)"
ssh-add ~/github/ssh/githubenjoyer1337/github_masterkey
