class Autocomplete < ActiveRecord::Base
	validates :name, :presence => true
end
