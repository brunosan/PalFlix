class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :pal
      t.integer :rating
      t.text :comment
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
