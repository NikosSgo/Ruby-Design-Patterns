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




