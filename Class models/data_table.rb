class DataTable
  def initialize(data)
    @data = data.map(&:freeze).freeze
  end
end
