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
    include_student = @data_list.elements.include?(student)
    if include_student then
      @data_list.elements = @data_list.elements.map do |el|
        el = student if el.id == id
        el
      end
      write_in_file
    end
  end

  def add_in_file(student)
    read_all_in_file!
    include_student = @data_list.elements.include?(student)
    if include_student then
      @data_list.elements = @data_list.elements.append(student)
      write_in_file
    end
  end


  def get_k_n_list_in_file(k, n, other_data_list = nil, filter: nil)
    students_count = count_students_in_file
    raise ArgumentError, 'Неверные значения k или n, k >=1, n >= 1' if k < 1  || n < 1  || (k - 1) * n >= students_count

    read_all_in_file!
    elements = filter ? filter.apply(@data_list.elements) : @data_list.elements
    paginated_elements = []
    elements.each_with_index do |el,ind|
      if ind >= (k - 1) * n && ind < (k - 1) * n + n then
        paginated_elements << el
      end
    end
    if other_data_list
      other_data_list.elements = paginated_elements
    else
      DataListStudentShort.new(paginated_elements)
    end
  end

  def count_students_in_file(filter = nil)
    read_all_in_file!
    filter ? filter.apply(@data_list.elements).size : @data_list.elements.size
  end

end
