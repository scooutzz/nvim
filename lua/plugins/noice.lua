return {
  --[['folke/noice.nvim'],
  event = 'VeryLazy',
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    cmdline = {
      enabled = true,
      view = 'cmdline',
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      -- Disabled fidget progress, and enabled this one
      progress = {
        enabled = true,
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    routes = {
      { -- Simpler notifications
        filter = {
          event = 'msg_show',
          any = {
            { find = 'written' },
            { find = 'yanked' },
            { find = 'Hunk' },
          },
        },
        view = 'mini',
      },
      { -- Hide "N lines ..." message
        filter = {
          event = 'msg_show',
          any = {
            { find = 'change;' },
            { find = 'changes;' },
            { find = 'lines' },
          },
        },
        opts = { skip = true },
      },
      { -- Hide search virtual text
        filter = {
          event = 'msg_show',
          kind = 'search_count',
        },
        opts = { skip = true },
      },
    },
    views = {
      mini = {
        win_options = {
          winblend = 0, -- Transparency
        },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  config = function(_, opts)
    require('notify').setup {
      merge_duplicates = true,
      background_colour = '#000000', -- Remove notification warning
      max_width = 50,
    }
    require('noice').setup(opts)
  end,]]
  --
}
