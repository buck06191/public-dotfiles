# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"


# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(
    command-not-found
    macos 
    git
    colored-man-pages
    rust
    zsh-autosuggestions
    zsh-syntax-highlighting
)

if [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fi

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"


# User configuration

export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export EDITOR='nvim'

alias szsh="source ${HOME}/.zshrc"

alias tm="tmux attach || tmux"

alias lg="lazygit"
# Custom bin path

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Neovim
alias vim=nvim

# git setup 

## Github
## Github GPG Signing
export GPG_TTY=$(tty)

## Clean up git branches
git_clean_remote() {
  git fetch -p && \
  for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); 
    do git branch -d $branch; 
  done
}

alias gfuckit='git commit --amend --no-edit && gpf' 


## SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> .ssh/ssh-agent
   fi
   eval `cat .ssh/ssh-agent`
fi


## Rust
. "$HOME/.cargo/env"

CARGO_NAME="Josh Buckland"
CARGO_EMAIL="josh.russell.buckland@gmail.com"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"


## Go
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"


# Optional Config 

## OS specific
if [[ "$(uname)" == "Darwin" ]]; then
test -f $HOME/.zshrc-mac && source $HOME/.zshrc-mac
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
test -f $HOME/.zshrc-linux && source $HOME/.zshrc-linux
fi


# fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

alias nvm=fnm



## KrakenFlex config
test -f $HOME/.zshrc-kf && source $HOME/.zshrc-kf

## secrets
test -f $HOME/.dotfiles/secrets && source $HOME/.dotfiles/secrets


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


