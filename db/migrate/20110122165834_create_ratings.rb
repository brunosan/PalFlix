class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :grade
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :movie_id
    add_index :ratings, :grade
    add_index :ratings, [:user_id, :movie_id], :unique =>true
  end

  def self.down
    drop_table :ratings
  end
end
