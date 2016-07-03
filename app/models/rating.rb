class Rating < ActiveRecord::Base

	belongs_to :user
	belongs_to :movie

	validate :already_rated

	def already_rated 
		 if Rating.where('user_id = ? AND movie_id = ?', self.user_id, self.movie_id).any?
		 	errors.add(:rated, "You have rated #{self.movie.title.capitalize} already!")
		 end
	end

end