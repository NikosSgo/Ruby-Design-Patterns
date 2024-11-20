require_relative "base_file_strategy"
class TxtFileStrategy < BaseFileStrategy

  private

  def from_file(str)
    str_students = str.split(";\n")
    id_and_info_students = str_students.map do |str|
      parts = str.split(",", 2)
      {
        id:parts[0].split("=")[1],
        info:parts[1]
      }
    end
  end
  
  def to_file(elements)
    strings = elements.map {|el| el.to_s + ";\n"}
    str = strings.inject {|acc,str| acc + str}
  end

end