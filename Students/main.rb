require_relative "StudentClass"

first_student = Student.new(surname: "Сгонниик", name: "Николай", patronymic: "Сергеевич",git: "https://github.com/NikosSgo", phone: "89286341261")
second_student = Student.new(surname: "Григоренко", name: "Никита", patronymic: "Алексеевич", phone: "89286313261")

puts "Данные первого студента : #{first_student}. Содержит гит и любой контакт: #{first_student.has_git_and_any_contact? ? "Да." : "Нет."}"
puts "Данные второго студента :#{second_student}. Содержит гит и любой контакт: #{second_student.has_git_and_any_contact? ? "Да." : "Нет."}"