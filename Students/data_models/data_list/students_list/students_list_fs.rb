require_relative "../student_short/data_list_student_short"

class StudentsListFS

  attr_writer :strategy, :data_list

  def initialize(strategy,data_list = nil)
    @strategy = strategy
    @data_list = data_list
  end

  def read_all_in_file
    DataListStudentShort.new(@strategy.read)
  end

  def read_all_in_file!
    elements = @strategy.read
    @data_list.elements = elements
    @data_list
  end

  def write_in_file
    @strategy.write(@data_list.elements)
    @data_list
  end

  def sort
    DataListStudentShort.new(@data_list.elements.sort_by(&:surname_and_initials))
  end
  
  def sort!
    @data_list.elements = @data_list.elements.sort_by(&:surname_and_initials)
    write_in_file
  end

  ########################################################

  def get_k_n_list_in_file(k,n,other_data_list = nil)
    students_count = count_students_in_file
    raise ArgumentError, 'Неверные значения k или n, k >=1, n >= 1' if k < 1 || n < 1 || (k-1)*n >= students_count
    elements = []
    for i in (k-1)*n...(k-1)*n+n do
      @data_list.select(i)
    end
    elements = @data_list.selected
    @data_list.clear_selected
    other_data_list.nil? ? @data_list.elements = elements : other_data_list.elements = elements 

  end

  def get_by_id_in_file(id)
    read_all_in_file!
    @data_list.elements.select {|el| el.id == id}
  end

  def delete_by_id_in_file(id)
    read_all_in_file!
    @data_list.elements = @data_list.elements.reject {|el| el.id == id}
    write_in_file
  end

  def update_by_id_in_file(id,student)
    read_all_in_file!
    @data_list.elements = @data_list.elements.map do |el|
      el = student if el.id == id
      el
    end
    write_in_file
  end

  def count_students_in_file
    read_all_in_file!
    @data_list.elements.length
  end

  def add_in_file(student)
    read_all_in_file!
    @data_list.elements = @data_list.elements.append(student)
    write_in_file
  end

end
