require_relative "base_file_strategy"
require "json"

class JsonFileStrategy < BaseFileStrategy

  private

  def from_file(json)
    JSON.parse(json,symbolize_names: true)
  end
  
  def to_file(elements)
    array_of_hashes = elements.map(&:to_hash)
    JSON.pretty_generate(array_of_hashes)
  end

end