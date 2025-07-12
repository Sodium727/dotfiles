require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.keymap.set('n', '<leader>o', ':silent update | !firefox "%"<CR><ESC>', { desc = "Open HTML in Firefox" })
vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set("n", "<leader>ls", ":!live-server %:p:h<CR>", { desc = "Start live-server" })

vim.g.python3_host_prog = "/usr/bin/python3" -- or wherever your python3 lives

