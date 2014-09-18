class CreateDbinfos < ActiveRecord::Migration
  def change
    create_table :dbinfos do |t|
      t.integer :s_version
      t.string :s_desc
      t.integer :Min_cversion
	  t.integer :Max_cversion
      t.string :c_desc
      t.date :doe
      t.string :link_new
      t.date :new_version
      t.string :feature_desc

      t.timestamps
	end
  end
end
