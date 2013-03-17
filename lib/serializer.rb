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

  def payload
    { id: object.id, object: object.class.name.to_s.downcase }
  end

  def to_json(*args)
    payload.to_json(*args)
  end

end
