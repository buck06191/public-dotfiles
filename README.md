# public-dotfiles
Public Dotfiles Repo

## Installation

Need to install:

- `fzf`, `rg`, `fd` 
- hack nerd font mono (to see the correct icons. Any nerd font will do)

Symlink any config files that can be symlinked across to the cloned repo. 
Any others will need to be kept in sync manually (e.g. if there are company specific requirements for the `.zshrc` file)

## Neovim

Use https://github.com/LazyVim/LazyVim to manage the setup.

To debug any problems run `:messages` and look at what the error is. It is probably the
case that some external package or language server isn't installed.
