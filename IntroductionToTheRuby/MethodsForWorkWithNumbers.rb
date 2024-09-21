#Метод 1 Найти количество делителей числа, не делящихся на 3

def divisors_not_divisible_by_3(number)
	divisors = (1..number).select { |i| i%3 != 0 and number % i == 0}
	return divisors.count
end


#Метод 2 Найти минимальную нечетную цифру числа.

def min_not_an_even_digit(number)
	digits = number.to_s.split("").map(&:to_i).select {|digit| digit%2!=0}
	return digits.min
end


#Метод 3 Найти сумму всех делителей числа, взаимно простых с суммой
#цифр числа и не взаимно простых с произведением цифр числа.

def sum_devisors(number)
	sum_digits =  0
	product_digits = 1
	digits = number.to_s.split("").map(&:to_i).each do |x|
		sum_digits += x
		product_digits *= x
	end
	sum_devisors = 0
	devisors = (1..number).select { |devisor| number%devisor == 0 and devisor.gcd(sum_digits) == 1 and devisor.gcd(product_digits) != 1}.each { |x| sum_devisors+= x}
	return sumDevisors
end

