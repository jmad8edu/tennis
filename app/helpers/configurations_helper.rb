module ConfigurationsHelper
	def faye_server
		if Rails.env.production?
			return "justinmadsen.me"
		else
			return "justinmadsen.me"
		end
	end
end