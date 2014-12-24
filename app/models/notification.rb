class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"
  has_one :notification_type

  def get_message
  	case self.notification_type_id
  		when 1;
  			"#{self.sender.name} invited you to a match!"
  		when 2;
  			"#{self.sender.name} accepted your invitation!"
  		when 3;
  			"#{self.sender.name} declined your invitation"
      when 4;
        "#{self.sender.name} wrote some trash talk for your match"
      when 5;
        "#{self.sender.name} updated your tennis match details"
  	end
  end

  def self.read
	 where(notified: true)
  end

  def self.unread
  	where(notified: false)
  end
end
