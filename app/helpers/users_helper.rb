module UsersHelper
	
	# Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 80, class: "gravatar" })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: options[:class])
	end

	def ntrp_rating(rating_id)
		case rating_id
			when 1;
				return "1.5"
			when 2;
				return "2.0"
			when 3;
				return "2.5"
			when 4;
				return "3.0"
			when 5;
				return "3.5"
			when 6;
				return "4.0"
			when 7;
				return "4.5"
			when 8;
				return "5.0"
			when 9;
				return "5.5"
			when 10;
				return "6.0"
			when 11;
				return "6.5"
			when 12;
				return "7.0"
		end
	end
end
