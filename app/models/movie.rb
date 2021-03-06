class Movie < ActiveRecord::Base

	belongs_to :user
	has_many :ratings
	has_many :comments, as: :commentable

	mount_uploader :poster, PosterUploader

	scope :search_genre, -> (genre) { where("genre LIKE ?", "#{genre}%") }
	scope :search_title, -> (title) { where("title LIKE ?", "#{title}%") }
	scope :search_duration, -> (runtime) { where("runtime #{self.right_duration_query(runtime)}") }
	scope :search, -> (title = "", runtime = "", genre = "") { self.search_title(title).search_duration(runtime).search_genre(genre) }

	def Movie.right_duration_query(runtime)
		case runtime
			when "under_90"
				"<= 90"
			when "over_90"
				"> 90"
			else 
				"> 0"
		end
	end
end
