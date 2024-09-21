require_relative "MinimalAndNumberFirstPositiveElementsArray"
def read_array_from_file(file_name)
	begin
		File.open(file_name,"r") do |file|
			array = file.read.split(',').map(&:strip)
		end
	rescue Errno::ENOENT => e
		# Обработка ошибки, если файл не найден
		puts "Ошибка: Файл не найден - #{e.message}"
	rescue Errno::EACCES => e
		# Обработка ошибки, если нет доступа к файлу
		puts "Ошибка: Доступ запрещен - #{e.message}"
	rescue StandardError => e
		# Обработка других стандартных ошибок
		puts "Произошла ошибка - #{e.message}"
	end
end
if ARGV.length == 2 then
	array = read_array_from_file(ARGV[1]).map(&:to_i)
	case ARGV[0]
		when "1"
			puts "Минимальный элемент массива - #{minimal_element(array)}"
		when "2"
			puts "Номер первого положительного элемента массива - #{number_first_positive_element(array)}"
		else
			puts "Первый аргумент программы - число от 1 до 2.\n1 - нахождение миниммума для массива.\n2 - номер первого положительного элемента массива."
	end
else
	puts "Корректно введите аргументы программы!\nПервый аргумент - число от 1 до 2.\n1 - нахождение миниммума для массива.\n2 - номер первого положительного элемента массива.\nВторой аргумент путь к файлу с массивом, который нужно считать."
end