require_relative "base_student"
require "json"

class StudentShort < BaseStudent
  
  #################################################
  
  #Геттеры и сеттеры	
  
  attr_reader :contact
  
  private :id=, :git=
  
  private_class_method :new
  
  #################################################
  
  # Инициализаторы
  
  def initialize(surname_and_initials:, id: nil, git: nil, contact: nil)
	super(id: id, git: git)
    @surname_and_initials = surname_and_initials
    @contact = contact
  end
    
  def self.from_json(json)
    hash  = JSON.parse(json)
    new(surname_and_initials: hash["surname_and_initials"], id: hash["id"], git: hash["git"], contact: hash["contact"])
  end
  
  def self.from_info(id: nil, info: nil)
    hash  = JSON.parse(info)
    new(surname_and_initials: hash["surname_and_initials"], id: id, git: hash["git"], contact: hash["contact"])
  end
  
  def self.from_student(student)
    if !student.nil?
      new(surname_and_initials: student.surname_and_initials, id: student.id, git: student.git, contact: student.get_contacts[0])
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
  
  valid_methods :initialize
end
