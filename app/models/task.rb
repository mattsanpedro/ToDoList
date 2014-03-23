class Task < ActiveRecord::Base
	validates :location, presence: true
end