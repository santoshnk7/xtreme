class RenamePlaceConnectionColumnName < ActiveRecord::Migration
  def up
  rename_column :place_connections, :place_a_id, :place_id
  end

  def down
  end
end
