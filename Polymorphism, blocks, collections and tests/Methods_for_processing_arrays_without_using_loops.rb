def is_this_element_global_minimum?(array,index)
  return array[index] == array.min
end

def swap_min_and_max_el(array)
  min = array.min
  max = array.max
  array.map do |el|
    if el == max
	  el = min
	elsif el == min
	  el = max
	end
	el
  end
end
	

