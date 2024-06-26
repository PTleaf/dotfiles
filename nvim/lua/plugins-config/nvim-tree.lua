local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree")
    return
end


nvim_tree.setup({
  sort_by = "case_sensitive",
    -- 是否显示 git 状态
    git = {
    enable = true,
    },
      update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = false
  },
  actions = {
      change_dir = {
          enable = false
      }
  },

    -- 过滤文件
    filters = {
        dotfiles = false, -- 过滤 dotfile
        custom = { }, -- 其他过滤目录
    },
  view = {
    -- 文件浏览器展示位置，左侧：left, 右侧：right
    side = "left",
    -- 行号是否显示
    number = true,
    relativenumber = true,
    signcolumn = "yes", -- 显示图标
  width = 40,
  },
  renderer = {
    group_empty = true,
  },
})
