local mode = {
  'mode',
  fmt = function(str)
    return ' ' .. str:sub(1, 1)
  end,
  draw_empty = true,
  color = { gui = 'bold' },
  separator = { left = '', right = '' },
}

return mode
