class AddAttrsUpdatedAtToPlace < ActiveRecord::Migration
  def change
    add_column :places, :attrs_updated_at, :datetime
  end
end
