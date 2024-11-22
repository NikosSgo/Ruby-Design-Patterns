require_relative "base_file_strategy"
class TxtFileStrategy < BaseFileStrategy

  private

  def from_file(str)
    str_students = str.split(";\n")
    students_hash = str_students.map do |str|
      str.split(",").map do |arg| 
        arg = arg.split("=")
        arg[1] = nil if arg[1] == 'nil'
        arg
      end
    end
    students_hash.to_h
  end
  
  def to_file(elements)
    strings = elements.map {|el| el.to_s + ";\n"}
    str = strings.inject {|acc,str| acc + str}
    str
  end

end