require_relative  "../data_table/data_table"
require_relative "../deep_dup/deep_dup"

class DataList
  include DeepDup

  attr_writer :elements

  def elements
    for i in 0...@elements.length do
      select(i)
    end
    sel_el = selected
    clear_selected
    sel_el
  end

  def initialize(elements = [])
    @elements = elements
    @selected = []
  end

  def select(number)
    raise ArgumentError, 'Invalid index' unless  number >= 0 && number < @elements.size
    @selected << @elements[number] unless @selected.include?(@elements[number])
  end

  def selected
    deep_dup(@selected)
  end

  def clear_selected
    @selected.clear
  end

  def get_names
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

  def get_data
    table = []
    @elements.each_with_index do |element, index|
      table << data_row(index+1,element)
    end
    DataTable.new(table)
  end

  protected
  
  def data_row
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

end
