module StudentValidator

  VALIDATIONS = {
    surname: ->(value) { valid_full_name?(value) },
    name: ->(value) { valid_full_name?(value) },
    patronymic: ->(value) { valid_full_name?(value) },
    surname_and_initials: ->(value) { valid_surname_and_initials?(value) },
    phone: ->(value) { value.nil? || valid_phone?(value) },
    telegram: ->(value) { value.nil? || valid_telegram?(value) },
    email: ->(value) { value.nil? || valid_email?(value) },
    git: ->(value) { value.nil? || valid_git?(value) },
    contact: ->(value) { value.nil? || valid_contact?(value) },
	birth_date: ->(value) {valid_date?(value) && valid_date_values?(value)}
  }
  
  protected def validate_attributes(binding, validations = VALIDATIONS)
    
    method_name = binding.eval('__method__')
	args = method(method_name).parameters.map { |_, name| [name, binding.local_variable_get(name)] }.to_h
	errors = []
	  
	args.each do |key, value|
	  validation = VALIDATIONS[key]
	  if !validation.nil?
	    unless validation.call(value)
		  errors << "Неверный аргумент: #{key} = #{value}"
		end
	  end
	end

	raise ArgumentError, errors.join(", ") unless errors.empty?
  end
  
  def self.valid_full_name?(full_name)
    full_name =~ /\A[A-ZА-ЯЁ][a-zа-яё]+\z/
  end
  
  def self.valid_surname_and_initials?(surname_and_initials)
    surname_and_initials =~ /\A[А-ЯЁ][а-яё]+ [А-ЯЁ]\.[А-ЯЁ]\.\z/
  end
  
  def self.valid_git?(git)
    git =~ /\Ahttps:\/\/github\.com\/[A-Za-z0-9_-]+\/?[A-Za-z0-9_-]*\z/
  end
  
  def self.valid_phone?(phone)
    phone =~ /\A(\+7|8)?\s?(\(?\d{3}\)?[\s-]?)?[\d\s-]{7,10}\z/
  end

  def self.valid_email?(email)
    email =~ /\A[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z_-]+\z/
  end

  def self.valid_telegram?(telegram)
    telegram =~ /\A\@[a-zA-Z0-9_]{5,32}\z/
  end
  
  def self.valid_contact?(contact)
    return true if contact.nil?
    
    contact.is_a?(Hash) &&
    (contact[:phone].nil? || valid_phone?(contact[:phone])) &&
    (contact[:email].nil? || valid_email?(contact[:email])) &&
    (contact[:telegram].nil? || valid_telegram?(contact[:telegram]))
  end
  
  def self.valid_date?(date)
    date =~ /^\d{4}-\d{2}-\d{2}$/
  end
  
  def self.valid_date_values?(date)
    year, month, day = date.split('-').map(&:to_i)
    return false if year < 1900 || year > 2100
    return false if month < 1 || month > 12
    return false if day < 1 || day > 31
    
	leap_year = 0
	leap_year+=1 if year%4==0
    days_in_month = [31, 28 + leap_year, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    day <= days_in_month[month-1]
  end

end

