class Match < ActiveRecord::Base
 	has_one :address, as: :addressable, dependent: :destroy
	belongs_to :result
	belongs_to :inviter, class_name: "User"
	belongs_to :invitee, class_name: "User"
	after_create :create_notification
	after_update :update_notification
	before_save :save_proper_formats

	validates :inviter_id,  presence: true
	validates :invitee_id,  presence: true
	validates :date, presence: true
	validates :time, presence: true
	validate :scheduled_date_check
  	accepts_nested_attributes_for :address

  	attr_accessor :date
  	attr_accessor :time

	def save_proper_formats
		self.scheduled_date = DateTime.strptime("#{self.date} #{self.time}", '%m-%d-%Y %H:%M %p')
	end

	def scheduled_date_check
		if (self.date != nil) && (self.date != "") &&
			(self.time != nil) && (self.time != "") &&
			DateTime.strptime("#{self.date} #{self.time}", '%m-%d-%Y %H:%M %p') == nil
			errors.add(:scheduled_date, "can't be blank")
		end
	end

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
