-- Custom Lualine progress component with configurable icon width
local function progress()
  -- get current and total lines
  local cur = vim.fn.line '.'
  local total = vim.fn.line '$'
  if total == 0 then
    return '' -- avoid division by zero
  end

  -- at top or bottom, show explicit labels with escaped percent signs
  if cur == 1 then
    return 'Top 0%%' -- '%%' yields a single '%' in the final statusline
  elseif cur == total then
    return 'Bot 100%%'
  end

  -- define Unicode blocks from empty to full
  local icons = { '▁', '▂', '▃', '▄', '▅', '▆', '█' }

  -- how many times each icon should be repeated for width
  local width_factor = 3

  -- compute ratio and rounded percentage
  local ratio = cur / total
  local pct = math.floor(ratio * 100 + 0.5)

  -- map ratio to icon index, clamped to [1, #icons]
  local idx = math.min(math.max(math.ceil(ratio * #icons), 1), #icons)

  -- repeat the selected icon width_factor times
  local bar = string.rep(icons[idx], width_factor)

  -- return bar + percentage, with '%%' so Lualine shows one '%'
  return bar .. ' ' .. pct .. '%%'
end

return progress
