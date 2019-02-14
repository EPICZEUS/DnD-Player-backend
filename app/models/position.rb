class Position < ApplicationRecord
  belongs_to :encounter
  belongs_to :playable, polymorphic: true
end
