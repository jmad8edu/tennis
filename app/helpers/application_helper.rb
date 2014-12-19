module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_param ? "current #{direction_param}" : nil
		direction = column == sort_param && direction_param == "asc" ? "desc" : "asc"
		link_to title, {direction: direction, sort: column}, {class: css_class}
	end

	def broadcast(channel, &block)
		message = {channel: channel, data: capture(&block)}
		uri = URI.parse("http://localhost:9292/faye")
		Net::HTTP.post_form(uri, message: message.to_json)
	end
end

