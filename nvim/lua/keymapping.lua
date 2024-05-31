vim.g.mapleader = " "
vim.g.maplocalleader = " "

local pluginKeys = {}

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

-- common
-- map("i", "<C-d>", "<esc>ddi", opt);

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<M-m>", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- ctrl+w 关闭  
map("n", "<C-w>", ":Bdelete!<CR>", opt)

-- diffview
map("v", "<leader>vf", ":'<,'>DiffviewFileHistory<CR>", opt);
map("n", "<leader>vc", ":DiffviewClose<CR>", opt);
map("n", "<leader>vf", ":DiffviewFileHistory", opt);
map("n", "<leader>vo", ":DiffviewOpen<CR>", opt);




-- window
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

-- 多窗口的打开与关闭
vim.api.nvim_set_keymap("n", "sv", ":vsp<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "sh", ":sp<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "sc", ":close<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "so", ":only<CR>", {noremap = true, silent = true})

-- lspsage
vim.api.nvim_set_keymap('n','<leader>t', '<cmd>Lspsaga term_toggle<CR>', opt)

-- telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opt);
map("n", "<C-g>", ":Telescope git_status<CR>", opt);
map("n", "<leader>bf", ":Telescope buffers<CR>", opt);
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opt);
--map("n", "<C-f>", ":Telescope live_grep<CR>", opt);
map("n", "<C-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opt)


-- monorepo
vim.keymap.set("n", "<leader>m", function()
  require("telescope").extensions.monorepo.monorepo()
end)
vim.keymap.set("n", "<leader>n", function()
  require("monorepo").toggle_project()
end)

-- lsp 
pluginKeys.mapLsp = function (mapbuf)
        -- rename
    mapbuf("n", "<leader>r", ":lua vim.lsp.buf.rename<CR>", opt)
    -- code action
    mapbuf("n", "<leader>ca", ":Lspsaga code_action<CR>", opt)
    -- go to definition
    mapbuf("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
    mapbuf("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opt)
    -- go to declaration
    mapbuf("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opt)
    -- show hover
    mapbuf("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
    mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
    -- format
    mapbuf("n", "<leader>=", ":lua vim.lsp.buf.format { async = true }<CR>", opt)
    mapbuf("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opt)
end

-- cmp
pluginKeys.cmp = function (cmp)
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end


    return {
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- 取消
        ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
--        ["<Esc>"] = cmp.mapping({
--            i = cmp.mapping.abort(),
--            c = cmp.mapping.close()
--        }),


        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace
        }),
        -- Super Tab
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
            end, {"i", "s"}),

            ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"})
    }
end

return pluginKeys;
