class AddDbUpdatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :db_updated_at, :datetime
  end
end
