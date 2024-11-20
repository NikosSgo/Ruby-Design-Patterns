require_relative "base_file_strategy"
require "json"

class JsonFileStrategy < BaseFileStrategy

  def from_file(json)
    JSON.parse(json,symbolize_names: true).map do |hash|
      {
        id: hash[:id],
        info: "surname_and_initials=#{hash[:surname_and_initials]},git=#{hash[:git]},contact=#{hash[:contact]}",
      }
    end
  end
  
  def to_file(elements)
    array_of_hashes = elements.map(&:to_hash)
    JSON.pretty_generate(array_of_hashes)
  end

end