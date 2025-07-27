require('mason-nvim-dap').setup({
  ensure_installed = { 'codelldb' },
  automatic_installation = true,  -- Auto-install any missing adapters on dap setup
  handlers = {},  -- Enables predefined adapter setups (including codelldb)
})

local dap = require('dap')

dap.configurations.c = {
  {
    name = 'Launch C',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch C++',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
