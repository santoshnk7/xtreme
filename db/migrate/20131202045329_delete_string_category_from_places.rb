class DeleteStringCategoryFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :string
    remove_column :places, :category
  end
  def down
    add_column :places, :string, :string
    add_column :places, :category, :string
  end
end
