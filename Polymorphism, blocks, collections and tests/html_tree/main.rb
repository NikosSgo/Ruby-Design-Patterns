require_relative "html_tree"

parsed_tree = HtmlTree.from_html('<html><body><div class="flex flex-col" color= "blue" ><div> Text node </div></div><div color="red"></div><input/></body><footer class=   "flex flex-col"></footer></html>')

puts "parsed_html to_html:\n\n#{parsed_tree.to_html}"

class_flex = "flex"
puts "\nВсе теги содержащие класс #{class_flex}в html:\n\n"

parsed_tree.select {|value| value.has_class?(class_flex)}.each_with_index {|value,index| puts "#{index+1})#{value.to_html_without_indent}\n\n"}