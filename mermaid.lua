function CodeBlock(el)
    if el.classes:includes('mermaid') then
        -- Generate a unique filename based on the Mermaid diagram content
        local base_filename = "mermaid-" .. pandoc.utils.sha1(el.text)
        local output_file = "/tmp/" .. base_filename .. ".png"

        -- Specify the local path to the mmdc binary. Adjust this path if necessary.
        local mmdc_path = "./node_modules/.bin/mmdc --outputFormat=png"  -- Adjust path if necessary

        -- Command to generate the diagram using mermaid-cli, with a higher scale factor
        local cmd = mmdc_path .. " -i <(echo '" .. el.text .. "') -o " .. output_file .. " --scale 2"

        -- Execute the command to render the diagram
        os.execute(cmd)

        -- Return the diagram as an embedded image in the final document
        return pandoc.Image(output_file, output_file)
    end
end

