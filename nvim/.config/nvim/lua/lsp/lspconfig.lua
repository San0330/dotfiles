local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

local function lspKeymaps(bufnr)
    local opts = { noremap = true, silent = true }

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "cf",
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
        opts
    )

    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local servers = {
    "jsonls", "lua_ls", "tsserver",
    "tailwindcss", "vimls",
    "intelephense", "emmet_ls", "html",
    'cssls', 'ccls'
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
    print('no cmp_nvim_lsp')
    return
end

local opts = {
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
        lspKeymaps(bufnr)
    end,
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
}

for _, server in pairs(servers) do
    local has_custom_opts, server_custom_opts = pcall(require, "alpine.lsp.settings." .. server)

    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    lspconfig[server].setup(opts)
end
