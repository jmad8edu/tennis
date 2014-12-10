class Result < ActiveRecord::Base
	belongs_to :winner, class_name: "User"
	belongs_to :loser, class_name: "User"
	has_one :match
end
