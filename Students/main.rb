require "json"
require_relative "StudentClass"
require_relative "StudentShort"
require_relative "BinarySearchTree"

first_student = Student.new(
  surname: "Сгонниик", 
  name: "Николай", 
  patronymic: "Сергеевич", 
  git: "https://github.com/NikosSgo", 
  phone: "89286341515",
  birth_date: "1998-05-12"
)

second_student = Student.new(
  surname: "Григоренко", 
  name: "Никита", 
  patronymic: "Алексеевич", 
  phone: "89286313262",
  birth_date: "2000-11-23"
)

puts "Данные первого студента : #{first_student}. Содержит гит и любой контакт: #{first_student.has_git_and_any_contact? ? "Да." : "Нет."}"
puts "\nДанные второго студента : #{second_student}. Содержит гит и любой контакт: #{second_student.has_git_and_any_contact? ? "Да." : "Нет."}"

# Обновляем контакты второго студента
second_student.set_contacts(email: "BigNikita@gmail.com")

puts "\nДанные второго студента после изменения методом set_contacts: #{second_student}. Содержит гит и любой контакт: #{second_student.has_git_and_any_contact? ? "Да." : "Нет."}"

# Вывод информации о первом студенте через метод get_info
puts "\nИнформация о первом студенте, полученная через get_info: #{first_student.get_info}"

# Создаем объекты StudentShort
first_student_short = StudentShort.from_info(id: "2", info: '{"surname_and_initials":"Сгонниик Н.С.","git":"https://github.com/NikosSgo","contact":{"phone":"89286341261"}}')
second_student_short = StudentShort.from_student(second_student)

puts "\nStudentShort, полученный через id и info: #{first_student_short.get_info}"
puts "\nStudentShort, полученный из полной версии класса Student: #{second_student_short.get_info}"

# Создаем студента из строки JSON
puts "\nStudent, полученный из конструктора строки: #{Student.from_json('{"surname":"Небывалов","name":"Максим","patronymic":"Алексеевич","id":"3","phone":"89286341261","birth_date":"2002-08-17","git":"https://github.com/NikosSgo"}').get_info}\n\n"

# Работа с файлом
file_dir = "StudentsArray.txt"

# Читаем массив студентов из файла
students_array = Student.read_from_txt(file_dir)

puts "Массив студентов, полученный из файла #{file_dir}\n\n"

students_array.each_with_index do |student, index|
  puts "#{index+1}) #{student.to_s}"
end

# Обновляем контакты второго студента в массиве
students_array[1].set_contacts(email: "Sido@gmail.com")

# Записываем обновленный массив студентов обратно в файл
Student.write_to_txt(students_array, "StudentsArray.txt")

binary_tree = BinarySearchTree.new()


students_array.each {|student| binary_tree.add(student)}

puts "Двоичное сортированное дерево студентов:\n#{binary_tree.to_hash}"