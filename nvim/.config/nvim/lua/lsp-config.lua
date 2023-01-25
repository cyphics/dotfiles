-- Setup lspconfig

local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set('n', '<space>q', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-q>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('i', '<C-q>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wl', function()
		vim.inspect(vim.lsp.buf.list_workspace_folders())
	end, opts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, _config or {})
end


-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'jsonls', 'bashls', 'solang', 'gopls',}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup (config())
end
require("lspconfig").sumneko_lua.setup(config({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

lspconfig.solang.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {"solang", "--language-server", "--target", "ewasm", "--importmap=hardhat=node_modules/hardhat" }
})

-- Setup nvim-cmp.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, {silent = true})

luasnip.config.set_config {
	-- This tells LS to remember to keep around the last snippet.
	-- You con jump back into it even if you move outside of the selection.
	history = true,

	updateevents = "TextChanged,TextChangedI",

}
local lspkind = require("lspkind")
lspkind.init()

cmp.setup({
snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format {
			mode = 'symbol',
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = '[LSP]',
				nvim_lua = '[api]',
				luasnip = '[snip]',
				path = '[path]',
			},
		},
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true  -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		["<C-Space>"] = cmp.mapping.complete(),
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "nvim_lsp_signature_help" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	}
})


local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})

