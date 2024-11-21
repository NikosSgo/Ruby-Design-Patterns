require_relative "base_file_strategy"
class TxtFileStrategy < BaseFileStrategy

  private

  def from_file(str)
    str_students = str.split(";\n")
    students_hash = str_students.map do |str|
      students_hash.split(",").map {|arg| arg.split("=")}.to_h
    end
    students_hash
  end
  
  def to_file(elements)
    strings = elements.map {|el| el.to_s + ";\n"}
    str = strings.inject {|acc,str| acc + str}
    str
  end

end