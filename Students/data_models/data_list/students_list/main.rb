require_relative "students_list"
require_relative "students_list_db"

first_student = StudentShort.from_info(id: "1", info: "surname_and_initials=Сгонниик Н.С.,git=https://github.com/NikosSgo,contact=89286341261")
second_student = StudentShort.from_info(id: "2", info: "surname_and_initials=Григоренко Н.А.,git=https://github.com/BigNikita2005,contact=89281332214")
third_student = StudentShort.from_info(id: "3", info: "surname_and_initials=Бачурин И.А.,git=https://github.com/BachIvan,contact=89331246944")
fourth_student = StudentShort.from_info(id: "4", info: "surname_and_initials=Небывалов М.В.,git=https://github.com/XMaxchel,contact=89113213355")


students = [first_student,second_student,third_student]

strategy = YamlFileStrategy.new()
student_list = StudentsList.new(strategy,students)

student_list.write_to_file("yaml_students.yaml")

student_list_db = StudentsListDB.new()

student_from_db = student_list_db.get_by_id(1)

puts "#{student_from_db}"



