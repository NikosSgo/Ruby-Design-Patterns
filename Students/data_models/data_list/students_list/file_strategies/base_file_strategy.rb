require_relative "../../../../student_short/student_short"

class BaseFileStrategy

  attr_accessor :file
  
  def initialize(file)
    @file = file
  end

  def read
    File.open(@file,"r") do |file|
      students_hash = from_file(file.read)
      students = students_hash.map do |hash| 
        StudentShort.new(id:hash[:id],surname_and_initials:hash[:surname_and_initials],git:hash[:git],contact:hash[:contact])
      end
      students
    end
  end
  
  def write(elements)
    File.open(@file,"w") do |file|
      file.write(to_file(elements))
    end
  end
  
end