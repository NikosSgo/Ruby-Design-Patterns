require_relative "base_filter"

class FilterDecorator < BaseFilter
  def initialize(base_filter, additional_filter)
    @base_filter = base_filter
    @additional_filter = additional_filter
  end

  def apply(data)
    @additional_filter.apply(@base_filter.apply(data))
  end

  def apply_db
    @base_filter.apply_db + ' AND ' + @additional_filter.apply_db
  end
end