def MinimalElement(array)
	if array.length > 0 then
		minElement = array[0]
		for x in array do
			if minElement > x then
				minElement = x
			end
		end
		return minElement
	else 
		return nil
	end
end

def NumberFirstPositiveElement(array)
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
