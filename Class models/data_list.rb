class DataList
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
    raise NotImplementedError, "Этот метод должен быть реализован в наследниках"
  end

  protected

def generate_table_data(elements)
    names = get_names
    table = []

    elements.each_with_index do |element, index|
      row = [index + 1]
      row += names.map { |name| element[name] }
      table << row
    end

    table
  end
end
