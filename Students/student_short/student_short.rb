require_relative "../base_student/base_student"
require "json"

class StudentShort < BaseStudent
  
  #################################################
  
  #Геттеры и сеттеры	
  
  attr_reader :contact, :surname_and_initials
  
  private :id=, :git=
  
  #################################################
  
  # Инициализаторы
  
  def initialize(surname_and_initials:, id: nil, git: nil, contact: nil)
	  super(id: id, git: git)
    @surname_and_initials = surname_and_initials
    @contact = contact
  end
  
  def self.from_info(id: nil, info: nil)
    hash = info.split(",").map do |value| 
      value = value.split("=")
      value[1] = nil if value[1] == "nil"
      value
    end
    hash = hash.to_h
    new(surname_and_initials: hash["surname_and_initials"], id: id, git: hash["git"], contact: hash["contact"])
  end	

  def self.from_student(student)
    if !student.nil?
      new(surname_and_initials: student.surname_and_initials, id: student.id, git: student.git, contact: student.contact)
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
    "surname_and_initials=#{surname_and_initials},git=#{git},contact=#{contact}"
  end
  
  def to_s
    "id=#{id},surname_and_initials=#{surname_and_initials},git=#{git},contact=#{contact}"
  end
  
  valid_methods :initialize
end
