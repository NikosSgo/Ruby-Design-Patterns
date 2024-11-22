require_relative "students_lists"
require_relative "file_strategies/file_strategies"
require_relative "storages/storages"
require_relative "filtration/filtration"

first_student = StudentShort.from_info(id: 1, info: "surname_and_initials=Сгонниик Н.С.,git=nil,contact=89286341261")
second_student = StudentShort.from_info(id: 2, info: "surname_and_initials=Григоренко Н.А.,git=https://github.com/BigNikita2005,contact=89281332214")
third_student = StudentShort.from_info(id: 3, info: "surname_and_initials=Бачурин И.А.,git=https://github.com/BachIvan,contact=89331246944")
fourth_student = StudentShort.from_info(id: 4, info: "surname_and_initials=Небывалов М.В.,git=https://github.com/XMaxchel,contact=nil")

has_git_filter = HasGitFilter.new()
has_contact_filter = HasContactFilter.new()
filters = FilterDecorator.new(has_git_filter,has_contact_filter)

students = [first_student,second_student,third_student,fourth_student]
data_list = DataListStudentShort.new(students)

strategy = YamlFileStrategy.new("yaml_students.yaml")
student_list_fs = StudentsListFS.new(strategy,data_list)
storage_adapter_fs = StorageFSAdapter.new(student_list_fs)

student_list_db = StudentsListDB.new()
storage_adapter_db = StorageDBAdapter.new(student_list_db)

students_list = StudentsList.new(storage_adapter_fs)

puts "\nТаблица с фильтрами из fs адаптера:"
student_table_fs = students_list.get_k_n_list(1,4,nil,filter: has_contact_filter).get_data
student_table_fs.print
puts "\nКоличество элементов в файле подходящих под фильтры"
puts students_list.get_students_count(has_contact_filter)

students_list.storage = storage_adapter_db

puts "\nТаблица с фильтрами из fs адаптера:"
student_table_db = students_list.get_k_n_list(1,4,nil,filter: has_contact_filter).get_data
student_table_db.print
puts "\nКоличество элементов в файле подходящих под фильтры"
puts students_list.get_students_count(has_git_filter)