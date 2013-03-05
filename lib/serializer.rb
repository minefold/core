require 'json'
require 'active_support/core_ext/class/attribute'

class Serializer

  class_attribute :attributes, instance_accessor: false

  attr_reader :object

  self.attributes = []

  def self.attribute(name)
    self.attributes += [name]
  end

  def initialize(object)
    @object = object
  end

  def as_json
    self.class.attributes.each_with_object({}) do |attr, json|
      json[attr] = @object.send(attr)
    end
  end

  def to_json(*args)
    as_json.to_json(*args)
  end

end
