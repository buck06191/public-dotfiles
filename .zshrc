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
    yarn-autocompletions
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"


# User configuration

export PATH=$HOME/.bin:$PATH
export EDITOR='nvim'

alias szsh="source ${HOME}/.zshrc"



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

# Zellij Aliases
alias "zjgo"="zellij action new-tab --layout ${HOME}/.config/zellij/layouts/golang_testing.kdl"


# fnm
export PATH=$HOME/.fnm:$PATH
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

alias "nvm"="fnm"


# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## Rust
. "$HOME/.cargo/env"

CARGO_NAME="Josh Buckland"
CARGO_EMAIL="josh.russell.buckland@gmail.com"

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"


## Go
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

## Elixir/Erlang
# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# elixir/erlang
export ERL_AFLAGS="-kernel shell_history enabled"

# opam configuration
[[ ! -r /Users/joshbuckland/.opam/opam-init/init.zsh ]] || source /Users/joshbuckland/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


# Optional Config 

## KrakenFlex config
test -f $HOME/.zshrc-kf && source $HOME/.zshrc-kf

## secrets
test -f $HOME/.dotfiles/secrets && source $HOME/.dotfiles/secrets

# zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload bashcompinit && bashcompinit
    autoload -Uz compinit && compinit
fi
