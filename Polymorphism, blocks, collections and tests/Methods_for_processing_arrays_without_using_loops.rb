require "json"
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

def contains_max_element_in_interval?(array,range)
  max = array.max
  array.each_index.select {|i| array[i] ==  max}.any? {|i| i>=range.min && i<=range.max}
end

def arithmetic_mean_abs_el_array(array)
  array.map(&:abs).sum.to_f/array.length
end

def select_el_bigger_arith_mean_less_max_el(array)
  max = array.max
  arith = array.sum.to_f/array.length
  array.select {|el| el>arith && el<max}
end

def keyboard_input_array
  array = []
  puts "Введите элементы массива:"
  el = gets.chomp
  while el!=""
    array << el.to_i
	el = gets.chomp
  end
  array
end

def keyboard_input_method_and_array
  puts "Выберите метод."
  puts "1) is_this_element_global_minimum?(array,index)"
  puts "2) swap_min_and_max_el(array)"
  puts "3) contains_max_element_in_interval?(array,range)"
  puts "4) arithmetic_mean_abs_el_array(array)"
  puts "5) select_el_bigger_arith_mean_less_max_el(array)"
  puts "Введите число от 1 до 5:"
  method = gets.chomp
  case method
    when "1"
	  array = keyboard_input_array
      puts "Введите индекс:"
	  index = gets.chomp.to_i
	  return is_this_element_global_minimum?(array,index)
	when "2"
	  array = keyboard_input_array
	  swap_min_and_max_el(array)
	when "3"
	  array = keyboard_input_array
      puts "Введите левую границу диапазона:"
	  a = gets.chomp.to_i
	  puts "Введите левую границу диапазона:"
	  b = gets.chomp.to_i
	  return contains_max_element_in_interval?(array,a..b)
	when "4"
	  array = keyboard_input_array
	  return arithmetic_mean_abs_el_array(array)
	when "5"
	  array = keyboard_input_array
	  return select_el_bigger_arith_mean_less_max_el(array)
	else
	  puts "Ввод чисел только от 1 до 5!"
  end
end

def read_method_and_array_from_file(file_name)
  File.open(file_name,"r") do |file|
    hash = file.read
	hash = JSON.parse(hash)
	return is_this_element_global_minimum?(hash["array"],hash["index"]) if hash["method"] == 1
	return swap_min_and_max_el(hash["array"]) if hash["method"] == 2
    return contains_max_element_in_interval?(hash["array"],eval(hash["range"])) if hash["method"] == 3
	return arithmetic_mean_abs_el_array(hash["array"]) if hash["method"] == 4
	return select_el_bigger_arith_mean_less_max_el(hash["array"]) if hash["method"] == 5
	"Номер метода - число от 1 до 5!" if hash["method"] > 5 || hash["method"] < 1
  end
end

def keyboard_input_or_read_from_file 
  if ARGV.length > 0 then
    puts "#{read_method_and_array_from_file(ARGV[0])}"
  else
  
    puts "#{keyboard_input_method_and_array}"
  end
end

keyboard_input_or_read_from_file