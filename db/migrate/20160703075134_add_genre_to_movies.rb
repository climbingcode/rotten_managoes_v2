class AddGenreToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :genre, :string, default: ''
  end
end
