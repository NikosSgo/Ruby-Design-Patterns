require_relative "html_tree"

parsed_tree = HtmlTree.from_html('<html><body><div class="flex flex-col"><div class="flex flex-col">ssss</div></div><div color="red"></div><input/></body><footer></footer></html>')

puts "parsed_html to_html:\n\n#{parsed_tree.to_html}"

puts "\nparsed_html to_json:\n\n#{parsed_tree.to_json}"

puts "\nВсе div в html:\n\n"

parsed_tree.select {|value| value.has_class?("flex")}.each_with_index {|value,index| puts "#{index+1})#{value.to_html_without_indent}\n\n"}