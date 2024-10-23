return {
	"ggandor/leap.nvim",
	config = function()
    local leap = require('leap')

    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Normal' })

    -- leap.opts.safe_labels = {}
    leap.opts.preview_filter = function () return false end
	end,
}
