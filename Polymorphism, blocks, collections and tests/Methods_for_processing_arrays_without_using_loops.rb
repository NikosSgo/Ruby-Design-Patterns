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

def contains_max_element_in_interval?(array,a,b)
  max = array.max
  array.each_index.select {|i| array[i] ==  max}.any? {|i| i>=a && i<=b}
  
end

def arithmetic_mean_abs_el_array(array)
  array.map(&:abs).sum.to_f/array.length
end


