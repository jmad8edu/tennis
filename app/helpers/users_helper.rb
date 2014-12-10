module UsersHelper
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
