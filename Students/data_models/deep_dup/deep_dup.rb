module DeepDup
  
  private
  def deep_dup(value)
    case value
    when nil, Numeric, TrueClass, FalseClass, Symbol
      value
    when String
      value.dup
    when Array
      value.map { |v| deep_dup(v) }
    when Hash
      value.transform_values { |v| deep_dup(v) }
    else
      deep_dup_custom_object(value)
    end
  end

  def deep_dup_custom_object(value)
    if value.respond_to?(:dup)
      value.dup
    else
      value
    end
  end

end
