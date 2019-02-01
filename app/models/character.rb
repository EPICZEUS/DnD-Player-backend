class Character < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  has_and_belongs_to_many :encounters
end
