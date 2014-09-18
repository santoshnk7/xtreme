class AddRatingToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :rating, :decimal,:precision => 3,:scale => 2

  end
end
