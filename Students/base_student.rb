require_relative "student_validator"
require_relative "student_validator_helper"
class BaseStudent

  extend StudentValidator
  include StudentValidatorHelper

  #################################################
  
  #Геттеры и сеттеры
  
  attr_accessor :id
  valid_attr_accessor :git
  def surname_and_initials
    "#{@surname} #{@name[0]}.#{@patronymic[0]}."
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
  
  #################################################
  
  #Чтение, запись с файла
  
  def self.read_from_txt(file_name)
    begin
      array = File.open(file_name, "r") do |file|
        file.readlines.map do |line|
          begin
            self.from_json(line.strip)
          rescue JSON::ParserError => e
            nil 
		  end
        end
	  end
      return array.compact
    end
    rescue Errno::ENOENT => e
      puts "Ошибка: Файл не найден - #{e.message}"
	  return []
    rescue Errno::EACCES => e
      puts "Ошибка: Доступ запрещен - #{e.message}"
	  return []
    rescue StandardError => e
      puts "Произошла ошибка - #{e.message}"
	  return []
  end

  def self.write_to_txt(students, file_name)
    begin
      File.open(file_name, "w") do |file|
        students.each do |student|
          file.puts(student.to_json)
        end
      end
    rescue Errno::EACCES => e
      puts "Ошибка: Доступ запрещен - #{e.message}"
    rescue StandardError => e
        puts "Произошла ошибка при записи в файл - #{e.message}"
    end
  end
  
end