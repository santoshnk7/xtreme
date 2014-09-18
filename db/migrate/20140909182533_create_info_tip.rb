class CreateInfoTip < ActiveRecord::Migration
  def up
  create_table :info_tips do |t|
      t.string :message
      t.string :image
	  t.integer :type
	  t.references :category
      t.integer :display_time
      t.boolean :close
      t.integer :show_limit
      t.boolean :active, default: false
	  
      t.timestamps
	end
  end

  def down
    drop_table "info_tips"
  end
end
