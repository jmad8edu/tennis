class Message < ActiveRecord::Base
	belongs_to :messagable, polymorphic: true
	belongs_to :sender, class_name: "User"
end
