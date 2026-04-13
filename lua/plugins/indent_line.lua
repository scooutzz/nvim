return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function()
      local hooks = require 'ibl.hooks'

      require('ibl').setup {
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          include = {
            node_type = {
              ['*'] = {
                'function_declaration',
                'function_definition',
                'method_definition',
                'class_definition',
                'if_statement',
                'for_statement',
                'while_statement',
                'switch_statement',
                'try_statement',
                'table_constructor',
                'object',
                'object_pattern',
                'object_type',
                'array',
                'arguments',
                'ternary_expression',
                'conditional_expression',
              },
              javascript = {
                'statement_block',
                'object',
                'array',
                'function_declaration',
                'arrow_function',
                'function',
                'method_definition',
                'class_declaration',
                'if_statement',
                'switch_statement',
                'for_statement',
                'while_statement',
                'try_statement',
                'ternary_expression',
                'parenthesized_expression',
              },
              typescript = {
                'statement_block',
                'object',
                'array',
                'function_declaration',
                'arrow_function',
                'function',
                'method_definition',
                'class_declaration',
                'if_statement',
                'switch_statement',
                'for_statement',
                'while_statement',
                'try_statement',
                'ternary_expression',
                'parenthesized_expression',
              },
              vue = {
                'element',
                'script_element',
                'style_element',
                'start_tag',
                'object',
                'array',
              },
            },
          },
        },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}