class Address < ActiveRecord::Base
	belongs_to :addressable, polymorphic: true
	before_save :save_correct_formats
	validates :address_1,  presence: true, length: { maximum: 100 }
	validates :city,  presence: true, length: { maximum: 100 }
	validates :state,  presence: true, length: { maximum: 100 }
	validate :state_check
	validates :country,  presence: true, length: { maximum: 100 }
	validate :country_check
	validates :postal_code,  presence: true, length: { maximum: 100 }
	validate :postal_code_check

	def save_correct_formats
		self.postal_code = GoingPostal.format_postcode(self.postal_code, "US")
		self.country = country.upcase
		self.state = state.capitalize
		self.city = city.split.map(&:capitalize).join(' ')
	end

	def postal_code_check
		if (self.postal_code != nil) && (self.postal_code != "") && (!GoingPostal.postcode? self.postal_code, "US")
			errors.add(:postal_code, "must be a valid zip code")
		end
	end

	def state_check
		if (self.state != nil) && (self.state != "") && (!Address.states.include? self.state.capitalize)
			errors.add(:state, "must be a valid state")
		end
	end

	def country_check
		if (self.country != nil) && (self.country != "") && (!Address.country.include? self.country.upcase)
			errors.add(:country, "must be a valid country")
		end
	end

	def to_s
		"#{self.address_1} #{self.address_2} #{self.city}, #{self.state} #{self.postal_code}"
	end

	def self.states
		[
			"Alabama",
			"Alaska",
			"Arizona",
			"Arkansas",
			"California",
			"Colorado",
			"Connecticut",
			"Delaware",
			"Florida",
			"Georgia",
			"Hawaii",
			"Idaho",
			"Illinois",
			"Indiana",
			"Iowa",
			"Kansas",
			"Kentucky",
			"Louisiana",
			"Maine",
			"Maryland",
			"Massachusetts",
			"Michigan",
			"Minnesota",
			"Mississippi",
			"Missouri",
			"Montana",
			"Nebraska",
			"Nevada",
			"New Hampshire",
			"New Jersey",
			"New Mexico",
			"New York",
			"North Carolina",
			"North Dakota",
			"Ohio",
			"Oklahoma",
			"Oregon",
			"Pennsylvania",
			"Rhode Island",
			"South Carolina",
			"South Dakota",
			"Tennessee",
			"Texas",
			"Utah",
			"Vermont",
			"Virginia",
			"Washington",
			"West Virginia",
			"Wisconsin",
			"Wyoming"
		]
	end

	def self.country
		[
			"USA"
		]
	end
end
