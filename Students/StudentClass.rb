class Student
  attr_accessor :id, :surname, :name, :patronymic, :telegram, :email, :git
  
  attr_reader :phone

  def initialize(surname:, name:, patronymic:, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    @id = id
    @surname = surname
    @name = name
    @patronymic = patronymic
    self.phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end

  def self.valid_phone?(phone)
    phone =~ /\A(\+7|8)?\s?(\(?\d{3}\)?[\s-]?)?[\d\s-]{7,10}\z/
  end
  
  def self.valid_name?(name)
    name =~ /\A[A-ZА-ЯЁ][a-zа-яё]+\z/
  end
  
  def self.valid_surname?(surname)
    surname =~ /\A[A-ZА-ЯЁ][a-zа-яё]+\z/
  end
  
  def self.valid_patronymic?(patronymic)
    patronymic =~ /\A[A-ZА-ЯЁ][a-zа-яё]+\z/
  end
  
  def self.valid_telegram?(telegram)
    telegram =~ /\A\@[a-zA-Z0-9_]{5,32}\z/
  end
  
  def self.valid_email?(email)
    email =~ /\A[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z_-]+\z/
  end
  
  def self.valid_git?(git)
    git =~ /\Ahttps:\/\/github\.com\/[A-Za-z0-9_-]+\/?[A-Za-z0-9_-]*\z/
  end
  
  def has_git?
	return !self.git.nil?
  end
  
  def has_any_contact?
	return !self.telegram.nil? || !self.email.nil? || !self.phone.nil?
  end
  
  def has_git_and_any_contact?
	return has_git? && has_any_contact?
  end
  
  def phone=(phone)
    if !phone.nil? && self.class.valid_phone?(phone)
      @phone = phone
    else
      raise ArgumentError, "Неверный формат телефонного номера"
    end
  end
  
  
  def to_s
    str = "surname: #{@surname}, name: #{@name}, patronymic: #{@patronymic}"
    str += ", id: #{@id}" if @id
    str += ", phone: #{@phone}" if @phone
    str += ", telegram: #{@telegram}" if @telegram
    str += ", email: #{@email}" if @email
    str += ", git: #{@git}" if @git
    return str
  end
end
