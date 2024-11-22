require "json"
require_relative "student/student"
require_relative "student_short/student_short"
require_relative "binary_search_tree/binary_search_tree"

first_student = Student.new(surname: "Сгонниик", name: "Николай", patronymic: "Сергеевич", git: "https://github.com/NikosSgo", phone: "89286341515", birth_date: "2004-12-05")
second_student = Student.new(surname: "Григоренко", name: "Никита", patronymic: "Алексеевич", phone: "89286313262",birth_date: "2005-08-11")
third_student = Student.new(surname: "Бачурин", name: "Иван", patronymic: "Алексеевич", phone: "89283221122",birth_date: "2004-04-20")


puts first_student
puts second_student

first_student_short = StudentShort.from_info(id: "2", info: "surname_and_initials=Сгонниик Н.С.,git=https://github.com/NikosSgo,contact=89286341261")
second_student_short = StudentShort.from_student(second_student)

students_array = [first_student,second_student,third_student]

binary_tree = BinarySearchTree.new()

students_array.each {|student| binary_tree.add(student)}
