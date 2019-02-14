class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :race, :char_class, :level, :str, :dex, :con, :int, :wis, :cha, :speed, :hp, :alignment, :armor_class
  has_one :user
  has_one :campaign
  has_many :positions
end
