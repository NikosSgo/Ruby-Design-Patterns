require_relative "../student_short/data_list_student_short"
require_relative "../../../student_short/student_short"
require_relative "file_strategies/file_strategies"

class StudentsList < DataListStudentShort

  def strategy(strategy)
    @strategy = strategy
  end

  def initialize(strategy,students = [])
    @strategy = strategy
    super(students)
  end

  def read_all(file_name)
    @strategy.read(file_name)
  end

  def read_from_file!(file_name)
    students = @strategy.read(file_name)
    @elements = students
  end

  def write_to_file(file_name)
    @strategy.write(file_name,elements)
  end

  def sort
    elements.sort_by(&:surname_and_initials)
  end
  
  def sort!
    elements.sort_by!(&:surname_and_initials)
  end

  ########################################################

  def get_k_n_students(k,n,data_list = nil)
    raise ArgumentError, 'Неверные значения k или n' if k < 0 || n < 1 || k*n >= @elements.size
    elements = []
    for i in k*n...k*n+n do
      select(i)
    end
    elements = selected
    clear_selected
    data_list.nil? ? DataListStudentShort.new(elements) : data_list.elements = elements 

  end

  def get_by_id(id)
    select(id)
    element = selected[0]
    clear_selected
    element
  end

  def delete_by_id(id)
    elements.delete_at(id)
  end

  def update_by_id(id,student)
    elements[id] = student
  end

  def get_students_count
    elements.length
  end

  def add(student)
    elements.append(student)
  end

end
