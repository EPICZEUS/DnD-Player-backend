class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :description, :name
  has_one :campaign

  has_many :creatures
  has_many :characters

  class CreatureSerializer < ActiveModel::Serializer
  	attributes :id, :name, :creature_type, :str, :dex, :con, :int, :wis, :cha, :challenge_rating, :armor_class, :speed, :hp, :alignment

  	has_many :positions
  end

  class CharacterSerializer < ActiveModel::Serializer
  	attributes :id, :name, :race, :char_class, :level, :str, :dex, :con, :int, :wis, :cha, :speed, :hp, :alignment, :armor_class
	  has_one :user
	  has_many :positions
  end
end
