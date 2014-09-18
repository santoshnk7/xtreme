class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.references :place
	  t.references :event
      t.string :message

      t.timestamps
    end
    add_index :tips, :place_id
  end
end
