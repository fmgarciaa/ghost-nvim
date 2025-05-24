-- This file defines a custom Lualine component to display the scroll progress
-- through the current file as a percentage and a simple graphical bar.

-- This component is defined as a function that Lualine will call to get the display string.
local function progress()
  -- Get the current cursor line number and the total number of lines in the buffer.
  local cur = vim.fn.line '.' -- Current line.
  local total = vim.fn.line '$' -- Total lines.

  -- If the buffer is empty (total lines is 0), return an empty string to avoid division by zero.
  if total == 0 then
    return ''
  end

  -- Handle edge cases: if at the very top or very bottom of the file.
  -- These display "Top 0%" or "Bot 100%" respectively.
  -- The '%%' is used to escape the '%' character, so it displays as a literal '%' in Lualine.
  if cur == 1 then
    return 'Top 0%%'
  elseif cur == total then
    return 'Bot 100%%'
  end

  -- Define a set of Unicode block characters to create a simple graphical progress bar.
  -- These characters represent increasing fill levels.
  local icons = { ' ', '▂', '▃', '▄', '▅', '▆', '█' } -- From empty to full block.

  -- Factor to determine the width of the graphical bar.
  -- Each selected icon will be repeated 'width_factor' times.
  local width_factor = 3

  -- Calculate the ratio of current line to total lines.
  local ratio = cur / total
  -- Calculate the percentage, rounded to the nearest whole number.
  local pct = math.floor(ratio * 100 + 0.5)

  -- Map the ratio to an index in the 'icons' table.
  -- math.ceil(ratio * #icons) scales the ratio to the number of icons.
  -- math.min and math.max clamp the index to be within the valid range of the 'icons' table [1, #icons].
  local idx = math.min(math.max(math.ceil(ratio * #icons), 1), #icons)

  -- Create the graphical bar by repeating the selected icon.
  local bar = string.rep(icons[idx], width_factor)

  -- Return the formatted string: graphical bar, space, percentage, and a literal '%'.
  return bar .. ' ' .. pct .. '%%'
end

-- Return the progress function, which Lualine will use as the component.
return progress

-- Example of how this might be used in lualine.setup sections:
-- sections = {
--   lualine_z = { require('plugins.appearance.lualine_comps.progress'), ... }
-- }
-- Or if the component itself is returned as a function directly:
-- sections = {
--   lualine_z = { progress_file, ... } -- where progress_file is this function.
-- }
-- The current lualine config uses the latter approach.
