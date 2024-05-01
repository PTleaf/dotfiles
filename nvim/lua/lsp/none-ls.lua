-- lsp/nonels.lua
-- 即使是采用了 none-ls, 这里也是获取 null-ls
local status, null_ls = pcall(require, "null-ls")
if not status then
    vim.notify("没有找到 null-ls")
    return
end

local formatters = null_ls.builtins.formatting


null_ls.setup({
    sources = {
        -- Stylua
        formatters.stylua,
        -- 其他 formatter 方式
        formatters.prettier,
    },
    -- 保存自动格式化
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
        end
    end,
})
