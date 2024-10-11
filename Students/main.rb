require_relative "StudentClass"

first_student = Student.new(surname: "Сгонниик", name: "Николай", patronymic: "Сергеевич",git: "https://github.com/NikosSgo", phone: "89286341261")
second_student = Student.new(surname: "Григоренко", name: "Никита", patronymic: "Алексеевич", phone: "89286313261")

puts "Данные первого студента : #{first_student}."
puts "Данные второго студента :#{second_student}."