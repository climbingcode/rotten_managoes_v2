class User < ActiveRecord::Base
	
	has_secure_password

	validates :password, presence: true, confirmation: true, length: { minimum: 8 }

	has_many :movies
	has_many :ratings
	has_many :comments

	scope :exclude, -> (user) { where('id != ?', "#{user.id}") }

end
