require_relative "../base_filter"

class FieldPresenceFilter < BaseFilter
  def initialize(field)
    @field = field
  end

  def apply_db
    "#{@field} IS NOT NULL"
  end
end