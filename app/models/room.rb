class Room < ApplicationRecord
	has_many :messages
  broadcasts_to :messages
end
