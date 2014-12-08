module ApplicationHelper
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_param ? "current #{direction_param}" : nil
		direction = column == sort_param && direction_param == "asc" ? "desc" : "asc"
		link_to title, {direction: direction, sort: column}, {class: css_class}
	end

	def my_pagination(collection, pages)
		controller_name = controller.controller_name
		collection ||= infer_collection_from_controller
		return nil unless collection.total_pages > 1
		if collection.total_pages >= 10
			"<div class='pagination-wrapper'>" +
			open_pagination("left") + 
			first_last_page("First", collection, controller_name) + 
			close_pagination +
			pages + 
			open_pagination("right") + 
			first_last_page("Last", collection, controller_name) + 
			close_pagination +
			open_pagination(nil, "visible-xs-block") + 
			first_last_page("First", collection, controller_name) + 
			first_last_page("Last", collection, controller_name) + 
			close_pagination +
			"</div>"
		else
			pages
		end
	end

	private
		def infer_collection_from_controller
		  controller_name = controller.controller_name
	      collection = instance_variable_get("@#{controller_name}")
	      raise ArgumentError, "The #{collection_name} variable appears to be empty. Did you " +
	        "forget to pass the collection object for will_paginate?" if collection.nil?
	      collection
	    end

	    def open_pagination (float = nil, klass = "hidden-xs")
	    	style = ''
	    	case float
		    	when nil;
					style = ''
				when "right";
					style = "style='float:right;'"
				when "left";
					style = "style='float:left;'"
			end
			"<div class='pagination #{klass}' #{style}><ul class='pagination'>"
	    end

	    def close_pagination
			"</ul></div>"
	    end

		def first_last_page (page, collection, controller_name)
			sort_parameters = "&direction=#{direction_param}&sort=#{sort_param}"
			klass = ''
			link = ''
			rel = ''
			case page
				when "First";
					disabled = params[:page] != "1" ? "" : "disabled"
					klass = "prev previous_page #{disabled}"
					link = "/#{controller_name}?page=1#{sort_parameters}"
					rel = "prev"
				when "Last";
					disabled = params[:page] != @users.total_pages.to_s ? "" : "disabled"
					klass = "next next_page #{disabled}"
					link = "/#{controller_name}?page=#{collection.total_pages}#{sort_parameters}"
			end
			"<li class='#{klass}'><a rel='#{rel}' href='#{link}'>#{page}</a></li>"
		end

		
end

