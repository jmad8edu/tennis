class Match < ActiveRecord::Base
	belongs_to :result
	belongs_to :inviter, class_name: "User"
	belongs_to :invitee, class_name: "User"
	after_create :create_notification
	after_update :update_notification

	def create_notification
		Notification.create!(receiver_id: 			self.invitee.id,
							 sender_id: 			self.inviter.id,
							 notification_type_id: 	1,
							 arg_id: 				self.id)
	end

	def update_notification
		Notification.create!(receiver_id: 			self.invitee.id,
							 sender_id: 			self.inviter.id,
							 notification_type_id: 	2,
							 arg_id: 				self.id)
	end

	def can_accept?(user)
		if user == self.inviter
			self.inviter_accepted == nil ? true : !self.inviter_accepted
		elsif user == self.invitee
			self.invitee_accepted == nil ? true : !self.invitee_accepted
		else
			false
		end
	end

	def can_reject?(user)
		if user == self.inviter
			self.inviter_accepted == nil ? true : self.inviter_accepted
		elsif user == self.invitee
			self.invitee_accepted == nil ? true : self.invitee_accepted
		else
			false
		end
	end
end
