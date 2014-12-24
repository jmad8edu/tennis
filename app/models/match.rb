class Match < ActiveRecord::Base
 	has_one :address, as: :addressable, dependent: :destroy
 	has_many :notifications, as: :notifiable, dependent: :destroy
 	has_many :messages, as: :messagable, dependent: :destroy
	belongs_to :result
	belongs_to :inviter, class_name: "User"
	belongs_to :invitee, class_name: "User"
	after_create :create_notification
	before_save :save_proper_formats
	after_initialize :set_date_and_time

	validates :inviter_id,  presence: true
	validates :invitee_id,  presence: true
	validates :date, presence: true, on: :create
	validates :time, presence: true, on: :create
	validate :scheduled_date_check
  	accepts_nested_attributes_for :address

  	attr_accessor :date
  	attr_accessor :time

	def save_proper_formats
		self.set_date_and_time
		self.scheduled_date = DateTime.strptime("#{self.date} #{self.time}", '%m-%d-%Y %H:%M %p')
	end

	def set_date_and_time
		if !self.scheduled_date.blank?
			self.date ||= self.scheduled_date.to_datetime.strftime("%m-%d-%Y")
			self.time ||= self.scheduled_date.to_datetime.strftime("%H:%M %p")
		end
	end

	def scheduled_date_check
		if (!self.date.blank?) && (!self.time.blank?) &&
			DateTime.strptime("#{self.date} #{self.time}", '%m-%d-%Y %H:%M %p') == nil
			errors.add(:scheduled_date, "must be proper format")
		end
	end

	def create_notification
		Notification.create!(receiver_id: 			self.invitee.id,
							 sender_id: 			self.inviter.id,
							 notification_type_id: 	1,
							 notifiable: 			self)
	end

	def response_notification(receiver, sender, accepted)
		Notification.create!(receiver_id: 			receiver.id,
							 sender_id: 			sender.id,
							 notification_type_id: 	accepted == "true" ? 2 : 3,
							 notifiable: 			self)
	end

	def edit_notification(receiver, sender)
		Notification.create!(receiver_id: 			receiver.id,
							 sender_id: 			sender.id,
							 notification_type_id: 	5,
							 notifiable: 			self)
	end

	def user_is_particpant?(user)
		user == self.inviter || user == self.invitee
	end

	def user_responded(user)
		if user == self.inviter
			self.inviter_accepted != nil
		elsif user == self.invitee
			self.invitee_accepted != nil
		end
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

	def can_decline?(user)
		if user == self.inviter
			self.inviter_accepted == nil ? true : self.inviter_accepted
		elsif user == self.invitee
			self.invitee_accepted == nil ? true : self.invitee_accepted
		else
			false
		end
	end

	def self.get_match_between_players(user1_id, user2_id)
		where("((inviter_id = #{user1_id} AND invitee_id = #{user2_id}) 
			OR (inviter_id = #{user2_id} AND invitee_id = #{user1_id}))
			AND scheduled_date > '#{DateTime.now}'")
	end

	def status
		if self.scheduled_date < DateTime.now
			"Past date"
		elsif self.inviter_accepted == nil
			"Awaiting response from #{self.inviter.name}"
		elsif self.invitee_accepted == nil
			"Awaiting response from #{self.invitee.name}"
		else
			"Ready for match"
		end
	end
end
