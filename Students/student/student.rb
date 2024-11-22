require_relative "../base_student/base_student"
require "json"

class Student < BaseStudent

  #################################################
  
  # Геттеры и сеттеры
  
  attr_reader :birth_date, :phone, :telegram, :email
  valid_attr_accessor :surname, :name, :patronymic
  def surname_and_initials
    "#{surname} #{name[0]}.#{patronymic[0]}."
  end
  
  #################################################
  
  # Инициализаторы
  
  def initialize(surname:, name:, patronymic:, birth_date:, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    super(id: id, git: git)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
	  @birth_date = birth_date
    @email = email
    @git = git
  end
  
  def self.from_json(json)
    hash = JSON.parse(json)
	Student.new(
	surname: hash["surname"], 
	name: hash["name"], 
	patronymic: hash["patronymic"], 
	birth_date: hash["birth_date"], 
	id: hash["id"],
	phone: hash["phone"], 
	telegram: hash["telegram"],
	email: hash["email"], 
	git: hash["git"]
	)
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
    @phone = phone if !phone.nil?
    @telegram = telegram if !telegram.nil?
    @email = email if !email.nil?
  end

  def contact
    contacts = []
	  contacts << @phone if @phone
    contacts << @email if @email
    contacts << @telegram if @telegram
    contacts[0]
  end
  
  #################################################

  def get_info
    "surname_and_initials=#{surname_and_initials},surname_and_initials=#{git},contact=#{contact}"
  end
  
  #################################################
  
  #Приведение к форматам

  def to_hash
    super.merge({
    surname: @surname,
	  name: @name,
	  patronymic: @patronymic,
	  birth_date: @birth_date,
	  phone: @phone,
	  email: @email,
	  telegram: @telegram,
    })
  end
  
  def to_json
	to_hash.to_json
  end
  
  def to_s
    str = "surname: #{@surname}, name: #{@name}, patronymic: #{@patronymic}, birth_date: #{birth_date}"
    str += ", id: #{@id}"
    str += ", phone: #{@phone}"
    str += ", telegram: #{@telegram}"
    str += ", email: #{@email}"
    str += ", git: #{@git}"
    str
  end

  #################################################
  
  # Метод для сравнения студентов по дате рождения
  def <=>(other)
    @birth_date <=> other.birth_date
  end
  
  #################################################
  
  # Валидация
  
  valid_methods :set_contacts, :initialize
  
end
