require_relative "base_filter"

class FieldLengthFilter < BaseFilter
  
  def initialize(field,length)
    @field = field
    @length = length
  end

end