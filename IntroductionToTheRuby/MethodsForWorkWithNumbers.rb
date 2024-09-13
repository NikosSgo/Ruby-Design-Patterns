#Метод 1 Найти количество делителей числа, не делящихся на 3

def DivisorsNotDivisibleBy3(number)
	divisors = (1..number).select { |i| i%3 != 0 and number % i == 0}
	return divisors.count
end






