require_relative "field_presence_filter"

class HasGitFilter < FieldPresenceFilter
  
  def initialize
    @field = 'git'
  end

  def apply(data)
    data.select { |student| !student.git.nil? }
  end

end