class Character < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  has_many :positions, as: :playable, dependent: :destroy

  has_many :encounters, through: :positions
end
