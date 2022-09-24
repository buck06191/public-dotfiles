# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(
    command-not-found
    macos 
    git
    colored-man-pages
    rust
    yarn-autocompletions
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/.bin:$PATH
export EDITOR='nvim'

alias szsh="source ${HOME}/.zshrc"



# Custom bin path

export PATH="$HOME/.bin:$PATH"

# fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"

alias "nvm"="fnm"

# Github GPG Signing
export GPG_TTY=$(tty)

## Github
# Clean up git branches
git_clean_remote() {
  git fetch -p && \
  for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); 
    do git branch -d $branch; 
  done
}

alias gfuckit='git commit --amend --no-edit && gpf' 

# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> .ssh/ssh-agent
   fi
   eval `cat .ssh/ssh-agent`
fi

# zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## Rust

. "$HOME/.cargo/env"

CARGO_NAME="Josh Buckland"
CARGO_EMAIL="josh.russell.buckland@gmail.com"


## Go
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
## Neovim
alias vim=nvim

## Secrets
source $HOME/.dotfiles/secrets
