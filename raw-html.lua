-- raw-html.lua
function Meta(meta)
    -- Open and read the external HTML file
    local file = io.open('form.html', 'r')
    if file then
        local content = file:read('*all')
        file:close()
        -- Assign the content as a RawBlock of type 'html'
        meta.form = pandoc.RawBlock('html', content)
    else
        -- Optional: Handle file not found
        meta.myvariable = pandoc.RawBlock('html', '<p>Error: content.html not found</p>')
    end
    return meta
end
