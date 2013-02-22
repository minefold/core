class FunpackSerializer < ActiveModel::Serializer
  root false

  attributes :id,
    :name,
    :description,
    :settingsSchema

  def settingsSchema
    object.settings_schema
  end

end
