class Notification < ActiveRecord::Base
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
			"#{self.sender.name} sent you a message!"
	end
  end

  def get_date
  	dt = self.created_at
  	if dt.to_date == Date.today
		dt.strftime("%l:%M %P")
	elsif dt.to_date == Date.yesterday
		"yesterday"
	else
		dt.strftime("")
	end
  end

  def get_object_ref
	 case self.notification_type_id
		when 1;
			return Match.find(self.arg_id)
		when 2;
			return Match.find(self.arg_id)
		when 3;
			return Match.find(self.arg_id)
	end
  end
end
