# dotfiles 🙆🏻

macOS Tahoe (26) dotfiles with oh-my-zsh, vim, VSCode, and Homebrew.

## Install

```bash
git clone git@github.com:pamo/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

## Directory Structure

```
dotfiles/
├── Brewfile              # Homebrew packages and casks
├── setup.sh              # Bootstrap script (idempotent)
├── macos.sh              # macOS Tahoe system defaults
├── .zshrc                # Zsh config with oh-my-zsh
├── .vimrc                # Vim config with vim-plug
├── .gitconfig            # Git config with delta, per-dir email
├── .gitignore            # Global git ignores
├── .inputrc              # Readline config
├── .npmrc                # npm config
├── vscode/
│   ├── settings.json     # Editor settings
│   ├── keybindings.json  # Key bindings
│   └── extensions.txt    # Installed extensions list
├── .vim/
│   ├── colors/           # Color schemes (fairyfloss)
│   └── spell/            # Spell check dictionaries
├── .iterm/               # iTerm2 color profiles
└── Sounds/               # Custom notification sounds
```

## Key Tools

| Tool | What it does | Usage |
|---|---|---|
| `zoxide` | Smart directory jumper | `z project`, `zi` for interactive |
| `mise` | Runtime version manager | `mise use node@22`, `mise use ruby@3.3` |
| `ripgrep` | Fast code search | `rg "pattern"` |
| `fd` | Fast file finder | `fd "*.json"` |
| `eza` | Modern file listing | `eza -la --icons --git` |
| `bat` | Syntax-highlighted cat | `bat file.txt` |
| `delta` | Better git diffs | Automatic via .gitconfig |
| `fzf` | Fuzzy finder | `ctrl-r` history, `ctrl-t` files |
| `gh` | GitHub CLI | `gh pr create`, `gh auth login` |

## Vim

Plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug). On first launch, vim-plug auto-installs itself and all plugins.

```vim
" Add to .vimrc inside plug#begin/end block:
Plug 'author/plugin-name'
```

Then run `:PlugInstall` in vim. `:PlugUpdate` to update all.

Key bindings:
- `ctrl-p` — fuzzy find files (fzf)
- `ctrl-f` — ripgrep search (fzf)
- `ctrl-b` — fuzzy find buffers
- `ctrl-n` — toggle NERDTree

## Per-Directory Git Email

The `.gitconfig` uses `includeIf` to set different emails per directory:

```bash
# ~/.gitconfig-personal
[user]
  email = your-personal-email

# ~/.gitconfig-work
[user]
  email = your-work-email
```

Projects in `~/me/` use the personal email, `~/dev/` uses work.

## Updating

```bash
brew bundle                              # Update brew packages
mise upgrade                             # Update runtimes
vim +PlugUpdate +qall                    # Update vim plugins
code --list-extensions > vscode/extensions.txt  # Snapshot extensions
```
