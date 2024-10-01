# Set the prompt color to red and make it bold
PS1='\[\e[1;31m\]\u@\h \w \[\e[0m\]\$ '

alias l="ls -lah --color=auto"
alias brave="nohup brave-browser & disown"
export PATH="$HOME/.cargo/bin:$PATH"
alias shutdown="sudo shutdown -h now"
alias chrome="nohup chromium & disown"
alias writer="libreoffice --writer"
alias calc="libreoffice --calc"
alias impress="libreoffice --impress"
alias draw="libreoffice --draw"
alias base="libreoffice --base"
alias pass="nohup keepassxc & disown"


# set history size
export HISTSIZE=20000
. "$HOME/.cargo/env"


# Function to get the current git branch
function parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Custom prompt to include git branch only if inside a git repository
export PS1="\[\033[01;34m\]\u@\h \[\033[01;32m\]\W\[\033[01;33m\]\$(parse_git_branch | sed 's/^/ git:(/;s/$/)/')\[\033[00m\] \$ "

# Start ssh-agent if it is not already running
eval "$(ssh-agent -s)"

# Add your SSH private key to the ssh-agent
ssh-add ~/github/ssh/githubenjoyer1337/github_masterkey
