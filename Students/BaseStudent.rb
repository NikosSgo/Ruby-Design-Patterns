require_relative "StudentValidator"

class BaseStudent

  include StudentValidator

  #################################################
  
  #Геттеры и сеттеры
  
  attr_accessor :id, :git
  
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