require_relative "field_presence_filter"

class HasContactFilter < FieldPresenceFilter
  
  def initialize
    @field = 'contact'
  end

  def apply(data)
    data.select { |student| !student.contact.nil? }
  end

end