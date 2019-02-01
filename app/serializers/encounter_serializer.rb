class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :campaign

  has_many :creatures
  has_many :characters
end
