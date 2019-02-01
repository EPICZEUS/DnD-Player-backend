class DmChannel < ApplicationRecord
	has_many :messages, as: :channel

	has_and_belongs_to_many :users

	validates :users, length: { is: 2 }
end
