class Movies < ActiveRecord::Migration
  def change
  	create_table :movies do |t|
  		t.string :title
  		t.string :director
  		t.string :poster
  		t.date :release_date
      t.integer :runtime
  		t.references :user
  		t.timestamps
  	end
  end
end
