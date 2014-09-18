class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
      t.references :place
	  t.references :event
      t.string :message

      t.timestamps
    end
    add_index :warnings, :place_id
  end
end
