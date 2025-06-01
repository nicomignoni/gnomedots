local state = {
    buf = -1,
    win = -1,
}

local function create_floating_window(opts)
  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Create the floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
	relative = "editor",
    	width = width,
    	height = height,
    	col = math.floor((vim.o.columns - width) / 2),
    	row = math.floor((vim.o.lines - height) / 2),
    	style = "minimal", -- No borders or extra UI elements
    	border = "rounded",
    })

  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.win) then
    state = create_floating_window { buf = state.buf }
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.win)
  end
  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<leader>t", toggle_terminal, { noremap = true, silent = true })
