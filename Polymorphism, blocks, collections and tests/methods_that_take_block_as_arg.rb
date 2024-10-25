class MyArray

  attr_reader :array
  
  def initialize(array)
    @array = array
  end
  
  def my_cycle(rep = nil)
    cycle = 0
    while(cycle != rep)
      for i in 0...@array.length do 
	    yield(@array[i])
	  end
	  cycle+=1
    end
  end
  
end