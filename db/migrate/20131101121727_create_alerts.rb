class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.references :user
      t.references :warning

      t.timestamps
    end
    add_index :alerts, :user_id
    add_index :alerts, :warning_id
  end
end
