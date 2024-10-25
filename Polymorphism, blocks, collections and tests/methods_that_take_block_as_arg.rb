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
  
  def my_inject(value = nil)
    start_index = 0
    if value.nil?
	  value = @array[0]
	  start_index = 1
	end
	
    for i in start_index...@array.length do
	  value = yield(value,@array[i])
	end
	value
  end
  
end