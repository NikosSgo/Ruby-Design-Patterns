require_relative "../student_validator/student_validator"
require_relative "../student_validator/student_validator_helper"

class BaseStudent

  extend StudentValidator
  include StudentValidatorHelper

  #################################################
  
  #Геттеры и сеттеры
  
  attr_accessor :id
  valid_attr_accessor :git
  def surname_and_initials
    raise NotImplementedError, "Геттер surname_and_initials должен быть реализован"
  end
  
  #################################################
  
  #Инициализация
  
  protected
  
  def initialize(id: nil, git: nil)
    @id = id
	  @git = git
  end
  
  #Наличие гита и приведение к типам
  
  def has_git?
    !@git.nil?
  end
  
  def to_hash
    {
	  id: @id,
	  git: @git,
	}
  end
  
  def to_json
	to_hash.to_json
  end
  
  def get_info
    raise NotImplementedError, "Метод get_info должен быть реализован"
  end
  
  def to_s
    raise NotImplementedError, "Метод to_s должен быть реализован"
  end
  
end