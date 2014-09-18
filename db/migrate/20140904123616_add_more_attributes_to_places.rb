class AddMoreAttributesToPlaces < ActiveRecord::Migration
  def change
  add_column :places, :cleanliness, :integer
  add_column :places, :p_type, :integer
  add_column :places, :star_rating, :integer
  add_column :places, :rest_type, :integer, default: 3
  end
end
