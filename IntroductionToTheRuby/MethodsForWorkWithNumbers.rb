#Метод 1 Найти количество делителей числа, не делящихся на 3

def DivisorsNotDivisibleBy3(number)
	divisors = (1..number).select { |i| i%3 != 0 and number % i == 0}
	return divisors.count
end


#Метод 2 Найти минимальную нечетную цифру числа.

def MinNotAnEvenDigit(number)
	digits = number.to_s.split("").map(&:to_i).select {|digit| digit%2!=0}
	return digits.min
end


#Метод 3 Найти сумму всех делителей числа, взаимно простых с суммой
#цифр числа и не взаимно простых с произведением цифр числа.

def SumDevisors(number)
	sumDigits =  0
	productDigits = 1
	digits = number.to_s.split("").map(&:to_i).each do |x|
		sumDigits += x
		productDigits *= x
	end
	puts "Сумма - #{sumDigits}, произведение - #{productDigits}"
	sumDevisors = 0
	devisors = (1..number).select { |devisor| number%devisor == 0 and devisor.gcd(sumDigits) == 1 and devisor.gcd(productDigits) != 1}.each { |x| sumDevisors+= x}
	return sumDevisors
end

