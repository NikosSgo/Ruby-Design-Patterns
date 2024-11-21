require_relative "../deep_dup/deep_dup"

class DataTable

  include DeepDup

  def initialize(data)
    @data = data
  end

  def get_element(row, col)
    deep_dup(@data[row][col])
  end

  def row_count
    @data.size
  end

  def column_count
    @data.empty? ? 0 : @data[0].size
  end

  #dev
  def print
    for i in 0...row_count do
      s = ""
      for j in 0...column_count do
        s+="#{get_element(i,j)} "
      end
      puts s
    end
  end
  
end
