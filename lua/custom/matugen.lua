-- ┳┓┏┓┏┓┓┏┳┳┳┓
-- ┃┃┣ ┃┃┃┃┃┃┃┃
-- ┛┗┗┛┗┛┗┛┻┛ ┗
--

-- Colorscheme gerado automaticamente pelo matugen
-- Não edite este arquivo manualmente

local M = {}

-- Cores base do matugen
local colors = {
	-- Cores primárias
	primary = "#a4c9fe",
	on_primary = "#00315c",

	-- Cores de superfície
	surface = "#111318",
	surface_bright = "#37393e",
	surface_dim = "#111318",
	surface_container = "#1d2024",
	surface_container_high = "#272a2f",
	surface_container_highest = "#32353a",
	surface_container_low = "#191c20",
	surface_container_lowest = "#0c0e13",

	on_surface = "#e1e2e9",
	on_surface_variant = "#c3c6cf",

	-- Cores de destaque
	secondary = "#bcc7db",
	on_secondary = "#263141",
	tertiary = "#d9bde3",
	on_tertiary = "#3c2946",

	-- Cores de erro/aviso
	error = "#ffb4ab",
	on_error = "#690005",

	-- Cores de contorno
	outline = "#8d9199",
	outline_variant = "#43474e",

	-- Background
	background = "#111318",
	on_background = "#e1e2e9",
}

-- Função para aplicar o colorscheme
function M.setup()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.background = "dark" -- ou "light" baseado nas cores
	vim.g.colors_name = "matugen"

	-- Grupos de highlight básicos
	local highlights = {
		-- Interface básica
		Normal = { fg = colors.on_background, bg = colors.background },
		NormalFloat = { fg = colors.on_surface, bg = colors.surface_container },
		FloatBorder = { fg = colors.outline, bg = colors.surface_container },

		-- Cursor e seleção
		Cursor = { fg = colors.on_primary, bg = colors.primary },
		CursorLine = { bg = colors.surface_container_low },
		CursorColumn = { bg = colors.surface_container_low },
		Visual = { bg = colors.surface_container_high },

		-- Line numbers
		LineNr = { fg = colors.outline },
		CursorLineNr = { fg = colors.on_surface, bold = true },

		-- Status line
		StatusLine = { fg = colors.on_surface, bg = colors.surface_container },
		StatusLineNC = { fg = colors.on_surface_variant, bg = colors.surface_container_low },

		-- Tabs
		TabLine = { fg = colors.on_surface_variant, bg = colors.surface_container_low },
		TabLineFill = { bg = colors.surface },
		TabLineSel = { fg = colors.on_surface, bg = colors.surface_container_high },

		-- Popup menus
		Pmenu = { fg = colors.on_surface, bg = colors.surface_container },
		PmenuSel = { fg = colors.on_primary, bg = colors.primary },
		PmenuSbar = { bg = colors.surface_container_high },
		PmenuThumb = { bg = colors.outline },

		-- Search
		Search = { fg = colors.on_secondary, bg = colors.secondary },
		IncSearch = { fg = colors.on_tertiary, bg = colors.tertiary },

		-- Syntax highlighting
		Comment = { fg = colors.on_surface_variant, italic = true },
		String = { fg = colors.secondary },
		Number = { fg = colors.tertiary },
		Boolean = { fg = colors.tertiary },
		Function = { fg = colors.primary },
		Keyword = { fg = colors.primary, bold = true },
		Type = { fg = colors.secondary },
		Identifier = { fg = colors.on_surface },
		Constant = { fg = colors.tertiary },

		-- Diff
		DiffAdd = { bg = colors.surface_container_high },
		DiffChange = { bg = colors.surface_container },
		DiffDelete = { fg = colors.error, bg = colors.surface_container_low },
		DiffText = { bg = colors.surface_container_highest },

		-- Diagnostics
		ErrorMsg = { fg = colors.error },
		WarningMsg = { fg = colors.tertiary },

		-- Splits
		VertSplit = { fg = colors.outline },
		WinSeparator = { fg = colors.outline },

		-- Fold
		Folded = { fg = colors.on_surface_variant, bg = colors.surface_container_low },
		FoldColumn = { fg = colors.outline },
	}

	-- Aplicar highlights
	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Highlights específicos para plugins populares
	-- Telescope
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.outline })
	vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.surface_container_high })

	-- Nvim-tree
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.on_surface, bg = colors.surface_container_low })
	vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.primary })

	-- LSP
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.tertiary })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.primary })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.secondary })
end

return M

-- return {
-- 	base00 = "#111318", -- background
-- 	base01 = "#e1e2e9", -- surface
-- 	base02 = "#c3c6cf", -- surface_variant
-- 	base03 = "#c3c6cf", -- comments/dim / outline / muted
-- 	base04 = "#c3c6cf", -- on_surface_variant
-- 	base05 = "#e1e2e9", -- foreground / on_surface
-- 	base06 = "#2e3035", -- inverse_on_surface
-- 	base07 = "#a4c9fe", -- primary
-- 	base08 = "#ffb4ab", -- red (error)
-- 	base09 = "#d9bde3", -- orange (tertiary / or primary_container)
-- 	base0A = "#bcc7db", -- yellow (secondary)
-- 	base0B = "#3a608f", -- green (primairy_container / or secondary_container)
-- 	base0C = "#3c4758", -- cyan (secondary_container / or parimary)
-- 	base0D = "#a4c9fe", -- blue (tertiary_container / or primary)
-- 	base0E = "#a4c9fe", -- magenta (on_primary_container / or tertiary)
-- 	base0F = "#ffb4ab", -- brown (error_container / or outline_variant)
-- }
