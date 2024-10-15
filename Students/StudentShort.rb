require_relative "BaseStudent"
require "json"

class StudentShort < BaseStudent
  
  attr_reader :surname_and_initials, :contact
  
  #################################################
  
  # Инициализаторы
  
  private def initialize(surname_and_initials, id = nil, git = nil, contact = nil)
    validate_attributes(binding)
    
	super(id: id, git: git)
    @surname_and_initials = surname_and_initials
    @contact = contact
  end
  
  def self.from_info(id: nil, info: nil)
    hash  = JSON.parse(info)
    StudentShort.new(hash["surname_and_initials"], id, hash["git"], hash["contact"])
  end
  
  def self.from_student(student = nil)
    if !student.nil?
      StudentShort.new(student.surname_and_initials, student.id, student.git, student.get_contacts[0])
    else
      raise ArgumentError, "Student can not be nil!"
    end
  end

  #################################################
  
  # Приведение к типам и вывод
  
  def to_hash 
    super.merge({
	  surname_and_initials: @surname_and_initials,
	  contact: @contact
	})
  end
  
  def get_info
    to_hash.to_json
  end
  
  def to_s
    s = "Surname and initials: #{@surname_and_initials}"
    s += ", id: #{@id}" if @id
    s += ", git: #{@git}" if @git
    if @contact
      s += ", contact: phone: #{@contact[:phone]}" if @contact[:phone]
      s += ", contact: email: #{@contact[:email]}" if @contact[:email]
      s += ", contact: telegram: #{@contact[:telegram]}" if @contact[:telegram]
    end
    s += "."
  end
end
