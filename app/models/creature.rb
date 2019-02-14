class Creature < ApplicationRecord
	has_many :positions, as: :playable, dependent: :destroy

  has_many :encounters, through: :positions
end
