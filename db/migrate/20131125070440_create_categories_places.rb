class CreateCategoriesPlaces < ActiveRecord::Migration
  def change
    create_table :categories_places, :id => false do |t|
      t.integer :category_id
      t.integer :place_id
    end
    add_index :categories_places, :category_id
    add_index :categories_places, :place_id
  end
end
