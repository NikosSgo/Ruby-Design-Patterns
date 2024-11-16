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
  
  def has_class?(class_name)
	  return false if props.nil?
	  return false if props[:class].nil?
	  classes = props[:class].split
	  puts "классы - #{classes}"
	  return classes.contains(class_name) ? true : false
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