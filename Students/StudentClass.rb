require_relative "BaseStudent"
require "json"

class Student < BaseStudent
  attr_accessor :surname, :name, :patronymic	
  attr_reader :phone, :telegram, :email

  #################################################
  
  # Инициализаторы
  
  def initialize(surname:, name:, patronymic:, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    validate_attributes(binding)
    
    super(id: id, git: git)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end
  
  def self.from_json(json)
    hash = JSON.parse(json)
	Student.new(surname: hash["surname"], name: hash["name"], patronymic: hash["patronymic"], id: hash["id"],phone: hash["phone"], telegram: hash["telegram"], email: hash["email"], git: hash["git"])
  end

  #################################################
  
  #Наличие гита и контактов
  
  private def has_any_contact?
    !@telegram.nil? || !@phone.nil? || !@email.nil?
  end

  def has_git_and_any_contact?
    has_git? && has_any_contact?
  end
	
  #################################################
  
  #Геттер и сеттер для всех контактов одновременно контактов
  
  def set_contacts(phone: nil, telegram: nil, email: nil)
    validate_attributes(binding)
    @phone = phone if !phone.nil?
    @telegram = telegram if !telegram.nil?
    @email = email if !email.nil?
  end

  def get_contacts
    contacts = []
	contacts << {phone: @phone} if @phone
    contacts << {email: @email} if @email
    contacts << {telegram: @telegram} if @telegram
    contacts
  end
  
  #################################################
  
  #Метод get_info
  
  def surname_and_initials
    "#{@surname} #{@name[0]}.#{@patronymic[0]}."
  end
  
  private def to_short_hash
	{
      surname_and_initials: surname_and_initials,
      git: @git,
      contact: get_contacts[0]
    }
  end
	
  def get_info
    to_short_hash.to_json
  end
  
  #################################################
  
  #Приведение к форматам

  def to_hash
    super.merge({
      surname: @surname,
	  name: @name,
	  patronymic: @patronymic,
	  phone: @phone,
	  email: @email,
	  telegram: @telegram,
    })
  end
  
  def to_json
	to_hash.to_json
  end
  
  def to_s
    str = "surname: #{@surname}, name: #{@name}, patronymic: #{@patronymic}"
    str += ", id: #{@id}" if @id
    str += ", phone: #{@phone}" if @phone
    str += ", telegram: #{@telegram}" if @telegram
    str += ", email: #{@email}" if @email
    str += ", git: #{@git}" if @git
    str
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
