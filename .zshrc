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
alias brave="nohup brave-browser "$@" &>/dev/null & disown"
alias shutdown="sudo shutdown -h now"
alias chrome="nohup chromium "$@" &>/dev/null & disown"
alias writer="libreoffice --writer"
alias calc="libreoffice --calc"
alias impress="libreoffice --impress"
alias draw="libreoffice --draw"
alias base="libreoffice --base"
alias keepass="nohup keepassxc "$@" &>/dev/null & disown"
alias gimp='nohup gimp "$@" &>/dev/null & disown'
alias discord="nohup discord "$@" &>/dev/null & disown"

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
# Check if ssh-agent is already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    # Start ssh-agent and capture its output
    eval "$(ssh-agent -s)" > /dev/null 2>&1
fi

# Add SSH keys from the mex_ssh_keys directory
if [ -d "$HOME/personal/mex_ssh_keys" ]; then
    for key in "$HOME/personal/mex_ssh_keys"/*; do
        # Check if the file is a regular file and not a public key
        if [ -f "$key" ] && [[ "$key" != *.pub ]]; then
            ssh-add "$key" 2>/dev/null || true
        fi
    done
fi




export PNPM_HOME="$HOME/.local/share/pnpm/"
export PATH="$PNPM_HOME:$PATH"

# pnpm
export PNPM_HOME="/home/user01/.local/share/pnpm/"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

zathura() {
    nohup /usr/bin/zathura "$@" &>/dev/null & disown
}

feh() {
    nohup /usr/bin/feh "$@" &>/dev/null & disown
}
# exports for ranger file open functionality
export EDITOR=vim
export VISUAL=vim
