class Message < ApplicationRecord
  belongs_to :channel, polymorphic: true
  belongs_to :user
end
