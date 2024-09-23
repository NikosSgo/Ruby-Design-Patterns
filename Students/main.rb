require_relative "StudentClass"

first_student = Student.new(surname: "Сгонниик", name: "Николай", patronymic: "Сергеевич",git: "https://github.com/NikosSgo")
second_student = Student.new(surname: "Григорегко", name: "Никита", patronymic: "Алексеевич")

puts "Данные первого студента : #{first_student}."
puts "Данные второго студента :#{second_student}."