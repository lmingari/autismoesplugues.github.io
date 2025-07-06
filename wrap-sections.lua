-- wrap-sections.lua
function Blocks (blocks)
  local new_blocks = {}
  local in_section = false
  local section_content = {}

  for i = 1, #blocks do
    local block = blocks[i]

    if block.t == "Header" and block.level == 3 then
      -- If we are already in a section, close it first.
      if in_section then
        table.insert(new_blocks, pandoc.Div(section_content, {class = "card"}))
      end
      -- Start a new section.
      in_section = true
      -- The h3 itself is the first element of the new section's content.
      section_content = {block}
    elseif in_section then
      -- If we are in a section, add the current block to it.
      -- We stop if we hit another header of the same or higher level.
      if block.t == "Header" and block.level <= 3 then
        table.insert(new_blocks, pandoc.Div(section_content, {class = "card"}))
        in_section = false
        -- This block is a new header, so process it normally in the next loop.
        table.insert(new_blocks, block)
      else
        table.insert(section_content, block)
      end
    else
      -- If not in a section, just add the block as is.
      table.insert(new_blocks, block)
    end
  end

  -- Make sure to close the last section if the document ends with it.
  if in_section then
    table.insert(new_blocks, pandoc.Div(section_content, {class = "card"}))
  end

  return new_blocks
end
