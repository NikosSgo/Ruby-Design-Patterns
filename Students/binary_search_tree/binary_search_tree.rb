class BinarySearchTree
  include Enumerable

  class Node
    attr_accessor :student, :left, :right

    def initialize(student)
      @student = student
      @left = nil
      @right = nil
    end
	
	def to_hash
	  {
	    student: @student.to_hash,
		left: @left&.to_hash,
		right: @right&.to_hash
	  }
	end
	
  end

  def initialize
    @root = nil
  end

  def add(student)
    @root = insert(@root, student)
  end

  def each(&block)
    depth_first_search(@root, &block)
  end
  
  def to_hash
	@root&.to_hash
  end

  private

  def insert(node, student)
    return Node.new(student) if node.nil?

    if student.birth_date < node.student.birth_date
      node.left = insert(node.left, student)
    else
      node.right = insert(node.right, student)
    end
    node
  end
   
  def depth_first_search(node, &block)
    return if node.nil?

    block.call(node.student)
    depth_first_search(node.left, &block)
    depth_first_search(node.right, &block)
  end
  
end



