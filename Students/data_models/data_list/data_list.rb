require_relative  "data_table"

class DataList

  def data(data)
    @elements = data
  end
  
  def initialize(elements)
    @elements = elements.map(&:freeze).freeze
    @selected = []
  end

  def select(number)
    @selected << number unless @selected.include?(number)
  end

  def get_selected
    selected = @selected.dup
    @selected.clear
    selected
  end

  def get_names
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

  def get_data
    table = []
    elements.each_with_index do |element, index|
      table << data_row(id,element)
    end
    DataTable.new(table)
  end
  
end
