-- Setup lspconfig
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
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
	vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
	-- vim.keymap.set('n',"gd", ":lua vim.lsp.buf.definition()<CR>")
	vim.keymap.set('n', "K", ":lua vim.lsp.buf.hover()<CR>")
	-- vim.keymap.set('n',"<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
	-- vim.keymap.set('n',"<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
	-- vim.keymap.set('n',"[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
	-- vim.keymap.set('n',"]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
	-- vim.keymap.set('n',"<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
	-- vim.keymap.set('n',"<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
	-- vim.keymap.set('n',"<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
	-- Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, _config or {})
end
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'jsonls', 'bashls', 'ccls'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup (config())
end

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
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind

			vim_item.menu = ({
				nvim_lsp = '[LSP]',
				luasnip = '[LuaSnip]',
	
				path = '[Path]',
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	  ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
	  ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
	},
	-- cmp.mapping.preset.insert({
      -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.abort(),
      -- ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	  -- ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
	  -- ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
  
    -- }),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lsp_signature_help" },
	},
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

