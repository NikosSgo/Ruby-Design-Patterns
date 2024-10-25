require "json"
class Tag 

  attr_accessor :name, :props, :childs, :text, :type, :parent
   
  def self.create_self_closing_tag(name,props = {})
    Tag.new(name,props,nil,"self_closing_tag",nil)
  end
  
  def self.create_text_node(text)
    Tag.new(nil,nil,nil,"text_node",text)
  end
  
  def self.create_tag(name,props = {})
    Tag.new(name,props,[],"default_tag",nil)
  end
  
  private def initialize(name,props,childs,type,text)
    @name = name
	@props = props
	@childs = childs
	@type = type
	@text = text
  end
  
  def add_child(tag)
    tag.parent = self  
    @childs << tag if @text.nil?
  end
  
  def add_props(key, value)
    @props[key] = value
  end
   
  def depth_first_search(&block)
    block.call(self)
	@childs.each {|child| child.depth_first_search(&block)} if @childs
  end
  
  def breadth_first_search(&block)
    queue = [self]
    until queue.empty?
      current_tag = queue.shift
      block.call(current_tag)
      queue.concat(current_tag.childs) if current_tag.childs
    end
  end
  
  def to_html_without_indent
    if @type == "text_node"
      "#{@text}"
    elsif @type == "default_tag"
      result = "<#{@name}"
      @props.each { |key, value| result += " #{key}=#{'"' + value + '"'}" }
	  result += ">"
	  @childs.each { |child| result += child.to_html_without_indent }
	  result += "</#{@name}>"
      result
	elsif @type == "self_closing_tag"
	  result = "<#{@name}"
	  @props.each { |key, value| result += " #{key}=#{'"' + value + '"'}" }
	  result += "/>"
	  result
	end
  end
  
  def to_html(indent_level = 0,indent = "  ")
    indent *= indent_level
    result = ""

    if @type == "text_node"
      result = "#{indent}#{@text}\n"
    elsif @type == "default_tag"
      result = "#{indent}<#{@name}"
      @props.each { |key, value| result += " #{key}=#{'"' + value + '"'}" } if @props
      result += ">\n"
      @childs.each { |child| result += child.to_html(indent_level + 1) }
      result += "#{indent}</#{@name}>\n"
      result
	elsif @type == "self_closing_tag"
	  result = "#{indent}<#{@name}"
      @props.each { |key, value| result += " #{key}=#{'"' + value + '"'}" } if @props
	  result += "/>\n"
    end

    result
  end
  
  def to_hash
    hash = {
      name: @name,
      props: @props,
      text: @text,
    }
	@childs ? hash[:childs] = @childs.map(&:to_hash) : hash[:childs] = @childs
	hash
  end
  
  def to_s
    to_hash.to_json
  end
  
  def to_json
    to_hash.to_json
  end
end


class HtmlTree

  include Enumerable
  
  attr_accessor :root
  
  def initialize(root)
    @root = root
  end

  def self.from_html(html)
    # Регулярное выражение для открывающих и закрывающих тегов
    open_and_close_tags = /<(\w+)(\s+[^>]*)?>|<\/(\w+)>|([^<>]+)|<(\w+)\s*\/>/
    
    tags = html.scan(open_and_close_tags).map do |arr|
      hash = {}
      hash[:open_tag] = arr[0] if arr[0]    			# Открывающий тег
      hash[:props] = arr[1] if arr[1]       			# Атрибуты открывающего тега
      hash[:close_tag] = arr[2] if arr[2]   			# Закрывающий тег
	  hash[:text_node] = arr[3] if arr[3]        		# Текстовый узел
	  hash[:self_closing_tag] = arr[4] if arr[4]        # Самозакрывающийся тег
      hash
    end
    
    root_el = tags.shift  # Получаем первый элемент — это корень
    current_tag = Tag.create_tag(root_el[:open_tag], parse_attributes(root_el[:props]))  # Создаем корневой элемент
    
    root = current_tag  # Сохраняем корневой элемент для возвращения
    
    tags.each do |tag|
      if tag[:open_tag]
        # Создаем новый тег для открывающего тега
        new_tag = Tag.create_tag(tag[:open_tag], parse_attributes(tag[:props]))
        current_tag.add_child(new_tag)
        current_tag = new_tag
      elsif tag[:close_tag]
        # Возвращаемся к родительскому тегу при закрывающем теге
        current_tag = current_tag.parent
	  elsif tag[:text_node]
        # Добавляем текстовый узел в текущий тег
        text_node = Tag.create_text_node(tag[:text_node].strip)
        current_tag.add_child(text_node) unless tag[:text_node].strip.empty?
	  elsif tag[:self_closing_tag]
        # Добавляем самозакрывающийся тег в текущий тег
        self_closing_tag = Tag.create_self_closing_tag(tag[:self_closing_tag],tag[:props])
        current_tag.add_child(self_closing_tag)
      end
    end
    
    HtmlTree.new(root)  # Возвращаем корневой элемент дерева
  end

  def self.parse_attributes(props_str)
    return {} unless props_str
    
    props = {}
    props_str.scan(/(\w+)="([^"]*)"/).each do |key, value|
      props[key] = value
    end
    props
  end
  
  def to_html
    @root.to_html
  end
  
  def each(&block)
    @root.depth_first_search(&block)
  end
  
  def depth_first_search(&block)
    @root.depth_first_search(&block)
  end
  
  def breadth_first_search(&block)
    @root.breadth_first_search(&block)
  end
  
  def to_s
    @root.to_s
  end
  
  def to_json
    @root.to_json
  end
end

parsed_tree = HtmlTree.from_html('<html><body><div class="flex flex-col"><div>ssss</div></div><div color="red"></div><input/></body><footer></footer></html>')

puts "parsed_html to_html:\n\n#{parsed_tree.to_html}"

puts "\nparsed_html to_json:\n\n#{parsed_tree.to_json}"

puts "\nВсе div в html:\n\n"

parsed_tree.select {|value| value.name == "div"}.each_with_index {|value,index| puts "#{index+1})#{value.to_html_without_indent}\n\n"}