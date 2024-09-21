def minimal_element(array)
	if array.length > 0 then
		min_element = array[0]
		for x in array do
			if min_element > x then
				min_element = x
			end
		end
		return min_element
	else 
		return nil
	end
end

def number_first_positive_element(array)
	if array.length > 0 then
		for i in 0..array.length-1 do
			if array[i] > 0 then
				return i
			end
		end
	else 
		return nil
	end
end
