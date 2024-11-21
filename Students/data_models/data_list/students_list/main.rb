require_relative "students_lists"
require_relative "file_strategies/file_strategies"
require_relative "storages/storages"


first_student = StudentShort.from_info(id: 1, info: "surname_and_initials=Сгонниик Н.С.,git=https://github.com/NikosSgo,contact=89286341261")
second_student = StudentShort.from_info(id: 2, info: "surname_and_initials=Григоренко Н.А.,git=https://github.com/BigNikita2005,contact=89281332214")
third_student = StudentShort.from_info(id: 3, info: "surname_and_initials=Бачурин И.А.,git=https://github.com/BachIvan,contact=89331246944")
fourth_student = StudentShort.from_info(id: 4, info: "surname_and_initials=Небывалов М.В.,git=https://github.com/XMaxchel,contact=89113213355")


students = [first_student,second_student,third_student,fourth_student]
data_list = DataListStudentShort.new(students)

strategy = YamlFileStrategy.new("yaml_students.yaml")
student_list_fs = StudentsListFS.new(strategy,data_list)
storage_adapter_fs = StorageFSAdapter.new(student_list_fs)

student_list_db = StudentsListDB.new()
storage_adapter_db = StorageDBAdapter.new(student_list_db)

students_list = StudentsList.new(storage_adapter_fs)

puts "Получил первый элемент из файла с помощью файлового адаптера:"
student_from_fs = students_list.get_by_id(3)
puts student_from_fs

students_list.storage = storage_adapter_db

puts "Получил первый элемент из базы с помощью адаптера для баз данных:"
student_from_db = students_list.get_by_id(3)
puts student_from_db