require_relative "base_file_strategy"
require "yaml"

class YamlFileStrategy < BaseFileStrategy

  private

  def from_file(yaml)
    YAML.safe_load(yaml, permitted_classes: [Symbol], symbolize_names: true)
  end
  
  def to_file(elements)
    array_of_hashes = elements.map(&:to_hash)
    array_of_hashes.to_yaml
  end
  
end