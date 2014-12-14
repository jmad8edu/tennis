module NotificationsHelper
	def get_time(datetime)
		datetime.strftime("%l:%M %P")
	end

	def get_date(datetime)
		if datetime.to_date == Date.today
			"Today"
		elsif datetime.to_date == Date.yesterday
			"Yesterday"
		elsif datetime.year > Date.today.year
			datetime.strftime("%b %e, %Y")
		else
			datetime.strftime("%b %e")
		end
	end

	def get_time_then_date(datetime)
		if datetime.to_date == Date.today
			get_time(datetime)
		else
			get_date(datetime)
		end
	end
end
