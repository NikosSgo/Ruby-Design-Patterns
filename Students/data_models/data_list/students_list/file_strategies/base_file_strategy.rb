require_relative "../../../../student_short/student_short"

class BaseFileStrategy
  def read(file_name)
    File.open(file_name,"r") do |file|
      id_and_info_students = from_file(file.read)
      students = id_and_info_students.map do |id_and_info| 
        StudentShort.from_info(id:id_and_info[:id],info:id_and_info[:info])
      end
    end
  end
  
  def write(file_name,elements)
    File.open(file_name,"w") do |file|
      file.write(to_file(elements))
    end
  end
  
end