class DataTable
  def initialize(data)
    @data = data.map(&:freeze).freeze
  end

  def get_element(row, col)
    @data[row][col]
  end

  def row_count
    @data.size
  end

  def column_count
    @data.empty? ? 0 : @data[0].size
  end
end
