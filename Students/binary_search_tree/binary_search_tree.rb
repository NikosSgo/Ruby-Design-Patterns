class BinarySearchTree
  include Enumerable

  class Node
    attr_accessor :data, :left, :right

    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end
	
	def to_hash
	  {
	    data: @data.to_hash,
		  left: @left&.to_hash,
		  right: @right&.to_hash
	  }
	end
	
  end

  def initialize
    @root = nil
  end

  def add(data)
    @root = insert(@root, data)
  end

  def each(&block)
    depth_first_search(@root, &block)
  end
  
  def to_hash
	@root&.to_hash
  end

  private

  def insert(node, data)
    return Node.new(data) if node.nil?

    if data < node.data
      node.left = insert(node.left, data)
    else
      node.right = insert(node.right, data)
    end
    node
  end
   
  def depth_first_search(node, &block)
    return if node.nil?

    block.call(node.data)
    depth_first_search(node.left, &block)
    depth_first_search(node.right, &block)
  end
  
end



