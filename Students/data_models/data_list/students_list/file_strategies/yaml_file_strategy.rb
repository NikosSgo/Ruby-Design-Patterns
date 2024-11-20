require_relative "base_file_strategy"
require "yaml"

class YamlFileStrategy < BaseFileStrategy
  def from_file(yaml)
    YAML.safe_load(yaml, permitted_classes: [Symbol], symbolize_names: true).map do |hash|
      {
        id: hash[:id],
        info: "surname_and_initials=#{hash[:surname_and_initials]},git=#{hash[:git]},contact=#{hash[:contact]}"
      }
    end
  end
  
  def to_file(elements)
    array_of_hashes = elements.map(&:to_hash)
    array_of_hashes.to_yaml
  end
end