class CreatePlacesOfInterest < ActiveRecord::Migration
  def change
    create_table :places_users, :id => false do |t|
      t.integer :place_id
      t.integer :user_id
    end
    add_index :places_users, :place_id
    add_index :places_users, :user_id
  end
end
