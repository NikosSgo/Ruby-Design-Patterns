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

  def to_s
    str = "surname: #{@surname}, name: #{@name}, patronymic: #{@patronymic}"
    str += ", id: #{@id}" if @id
    str += ", phone: #{@phone}" if @phone
    str += ", telegram: #{@telegram}" if @telegram
    str += ", email: #{@email}" if @email
    str += ", git: #{@git}" if @git
    return str
  end

  def self.valid_phone?(phone)
    phone =~ /\A(\+7|8)?\s?(\(?\d{3}\)?[\s-]?)?[\d\s-]{7,10}\z/
  end

  def phone=(phone)
    if !phone.nil? && self.class.valid_phone?(phone)
	  puts "#{phone.nil?}"
      @phone = phone
    else
      raise ArgumentError, "Неверный формат телефонного номера"
    end
  end
end
