module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_param ? "current #{direction_param}" : nil
		direction = column == sort_param && direction_param == "asc" ? "desc" : "asc"
		link_to title, {direction: direction, sort: column}, {class: css_class}
	end

	def get_date(date)
		if date.to_date == Date.today
			date.strftime("%l:%M %P")
		elsif date.to_date == Date.yesterday
			"yesterday"
		elsif date.year > Date.today.year
			date.strftime("%b %e, %Y")
		else
			date.strftime("%b %e")
		end
	end
end

