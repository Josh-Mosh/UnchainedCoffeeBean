class Address < ActiveRecord::Base
	belongs_to :addressable, polymorphic: true

	validates :address, uniqueness: true
	geocoded_by :address
	after_validation :geocode
end
