vim.opt.colorcolumn = "80"
vim.opt.clipboard:append {"unnamedplus", "unnamed" }
vim.opt.relativenumber = true

if vim.fn.has("wsl") == 1 then
  -- if vim.fn.executable("wl-copy") == 0 then
  --   print("wl-clipboard not found, clipboard integration won't work.")
  -- else
    -- vim.g.clipboard = {
    --   name = "WslClipboard",
    --   copy = {
    --     ["+"] = 'clip.exe',
    --     ["*"] = 'clip.exe',
    --    },
    --    paste = {
    --       ["+"] = 'powershell.exe -c [Console]::Out.Write(c)',
    --       ["*"] = ''
    --     },
    --     cache_enabled = true
    --   }
  end

vim.g.clipboard = {
  name = 'tmux',
  copy = {
    ["+"] = {'tmux', 'load-buffer', '-'},
    ["*"] = {'tmux', 'load-buffer', '-'},
  },
  paste = {
    ["+"] = {'tmux', 'save-buffer', '-'},
    ["*"] = {'tmux', 'save-buffer', '-'}
  }
}
--
  -- elseif !empty($TMUX) && executable('tmux')
  --   let tmux_v = v:lua.vim.version.parse(system(['tmux', '-V']))
  --   if !empty(tmux_v) && !v:lua.vim.version.lt(tmux_v, [3,2,0])
  --     let s:copy['+'] = ['tmux', 'load-buffer', '-w', '-']
  --   else
  --     let s:copy['+'] = ['tmux', 'load-buffer', '-']
  --   endif
  --   let s:paste['+'] = ['tmux', 'save-buffer', '-']
  --   let s:copy['*'] = s:copy['+']
  --   let s:paste['*'] = s:paste['+']
  --   return 'tmux'
  -- endif
