NOTES.md

<!-- nvim  -->

-- open netrw
keymap.set("n", "<leader>e", vim.cmd.Ex)

-- move selection
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- easy replace
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Personal tools
-- cht.sh
keymap.set("n", "<C-h>", ":silent !tmux split-window -h bash -c cht.sh<CR>")

-- Telescope kemaps

local localModule = {}
localModule.search_dotfiles = function()
-- TODO: can specific directories be ignored. e.g. .git
telescope.find_files({
prompt_title = "My Dotfiles",
cwd = '~/dotfiles',
hidden = true,
})
end

keymap.set('n', '<leader>ff', telescope.find_files, {})
keymap.set('n', '<leader>fd', localModule.search_dotfiles, {})
keymap.set('n', '<leader>fg', telescope.live_grep, {})
keymap.set('n', '<c-f>', telescope.current_buffer_fuzzy_find, {})
keymap.set('n', '<leader>fs', ':Telescope file_browser<CR>')

-- Harpoon keymaps
keymap.set('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>')
keymap.set('n', '<leader>hl', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>')
keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>')
keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>')
keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>')
keymap.set('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>')
keymap.set('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<CR>')

-- theming
https://github.com/jesseleite/nvim-noirbuddy

<!-- tmux -->

-- SCRIPT tmux-sessionizer [https://github.com/harleylara/dotfiles/blob/eee778b1fc02475aed6d1ccaa8ce94c387cc96cd/bin/.local/bin/tmux-sessionizer]
#!/bin/bash

DIRECTORIES=$(cat ~/.tmux-dirs | tr "\n" " ")

if [[$# -eq 1]]; then
SELECTED=$1 && [[ "$SELECTED" == '.' ]] && SELECTED="$PWD"
else
    SELECTED=$(find $DIRECTORIES -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[-z $SELECTED]]; then
exit 0
fi

SELECTED*NAME=$(basename "$SELECTED" | tr . *)
SELECTED_NAME=${SELECTED_NAME:0:8}

if [[-n $TMUX]]; then # inside tmux
tmux switch-client -t "$SELECTED_NAME" || \
    tmux new-session -ds "$SELECTED_NAME" -c "$SELECTED" && \
    tmux switch-client -t "$SELECTED_NAME"
elif [[-z $TMUX]]; then # outside tmux
tmux new-session -s "$SELECTED_NAME" -c "$SELECTED" || \
 tmux attach -t "$SELECTED_NAME"
fi

-- .config/tmux/tmux-dir
~/
/mnt/d/git-ws
/mnt/d/git-ws/externals
/mnt/d/projects/dev
/mnt/d/learning/
/mnt/c/Users/harle
/mnt/c/Users/harle/Documents
