module StudentValidator

  def valid_attr_accessor(*attr_names)
    valid_attr_writer(*attr_names)
    attr_reader(*attr_names)
  end

  def valid_attr_writer(*attr_names)
    attr_names.each do |attr_name|
      define_method("#{attr_name}=") do |value|
        raise ArgumentError, "Неверный аргумент: #{value}" if !valid_arg?(attr_name, value)
        instance_variable_set("@#{attr_name}", value)
      end
    end
  end

  def valid_methods(*method_names)
    method_names.each do |method_name|
      alias_method "#{method_name}_without_validation", method_name
      private "#{method_name}_without_validation"

      define_method(method_name) do |**kwargs|
        validate_attributes(kwargs)
        send("#{method_name}_without_validation", **kwargs)
      end
    end
  end

end