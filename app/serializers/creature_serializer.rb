class CreatureSerializer < ActiveModel::Serializer
  attributes :id, :name, :creature_type, :str, :dex, :con, :int, :wis, :cha, :challenge_rating, :armor_class, :speed, :hp, :alignment
end
