local prettier = {
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local eslint = {
  lintCommand = 'eslint --format visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %rror %m',
  },
  lintSource = 'eslint',
}

local shellcheck = {
  lintCommand = 'shellcheck --format=gcc --external-sources -',
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %trror: %m',
    '%f:%l:%c: %tarning: %m',
    '%f:%l:%c: %tote: %m',
  },
  lintSource = 'shellcheck',
}

local pylint = {
  lintCommand = "pylint --output-format text --reports n --msg-template='{path}:{line}:{column}: {msg_id} ({symbol}) {msg}' ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = false,
  lintFormats = {
    '%f:%l:%c:%t:%m',
  },
  lintSource = 'pylint',
  lintOffsetColumns = 1,
  lintCategoryMap = {
    I = 'H',
    R = 'I',
    C = 'I',
    W = 'W',
    E = 'E',
    F = 'E',
  },
}

local languages = {
  python = { pylint },
  vue = { eslint, prettier },
  typescript = { eslint, prettier },
  javascript = { eslint, prettier },
  ['typescript.tsx'] = { eslint, prettier, },
  ['javascript.jsx'] = { eslint, prettier },
  typescriptreact = { eslint, prettier, },
  javascriptreact = { eslint, prettier },
  sh = { shellcheck },
  bash = { shellcheck },
}

return {
  -- cmd = {"efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "5"},
  init_options = { documentFormatting = false, codeAction = true },
  root_dir = vim.loop.cwd,
  filetypes = vim.tbl_keys(languages), -- needed to work on new buffers
  settings = {
    rootMarkers = { '.git/', vim.loop.cwd() },
    languages = languages,
  },
}

