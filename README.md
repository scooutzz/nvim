# My Neovim Configuration

Personal Neovim configuration with modular structure.

## Structure

```
lua/
├── autocmds/          -- Autocommands
├── config/            -- Options and keymaps
└── plugins/           -- All plugins (auto-loaded)
```

## Plugins

- **Telescope** - Fuzzy finder
- **LSP** - nvim-lspconfig + Mason
- **Completion** - blink.cmp + luasnip
- **Treesitter** - Syntax highlighting
- **Git** - gitsigns, fugitive
- **UI** - tokyonight, mini.statusline
- And more in `lua/plugins/`

## Installation

1. Clone to `~/.config/nvim`:
```sh
git clone git@github.com:scooutzz/nvim.git ~/.config/nvim
```

2. Open Neovim - Lazy will install plugins automatically:
```sh
nvim
```

## Requirements

- Neovim (latest stable or nightly)
- git
- make
- ripgrep
- Nerd Font (optional)

## Usage

- `:Lazy` - Manage plugins
- `:Mason` - Install LSP servers and tools
- `:Telescope` - Fuzzy search

## Adding New Plugins

Just add a new `.lua` file in `lua/plugins/`. Lazy loads automatically!