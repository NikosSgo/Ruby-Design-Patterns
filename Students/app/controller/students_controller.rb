require_relative "../../data_models/data_list/students_list/students_lists"
require_relative "../../data_models/data_list/students_list/storages/storages"
require_relative "../../data_models/data_list/student_short/data_list_student_short"

class StudentsController
  
  def initialize(view)
    self.view = view
    self.students_model = StudentsList.new(StorageDBAdapter.new(StudentsListDB.new))
    self.data_list =  DataListStudentShort.new
    self.data_list.add_observer(self.view)
  end

  def refresh_data
    self.students_model.get_k_n_list(self.view.current_page, self.view.class::ROWS_PER_PAGE,self.data_list)
    self.data_list.count = self.students_model.get_students_count
    self.data_list.notify
  end

  def sort_by_column!(index)
    case index
    when 1
        puts "Сортировка по фамилии"
    end
  end

  def add
    puts "Добавление студента"
  end

  def update
    refresh_data
  end

  def edit(index)
    puts "Изменение студента с индексом: #{index}"
  end

  def delete(indexes)
    puts "Удаление студентов с индексами: #{indexes}"
  end

  private

  attr_accessor :view, :students_model, :data_list

end