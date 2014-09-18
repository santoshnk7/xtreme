class AddDetailsToEvents < ActiveRecord::Migration
  def change
	  add_column :events, :status, :string ,default:'Pending'
	  add_column :events, :featured_photo, :string
	  add_column :events, :info_updated_at, :datetime
	  add_column :events, :attrs_updated_at, :datetime
	  add_column :events, :contact_photo, :string
      add_column :events, :contact_detail, :string
	  add_column :events, :location, :string
	  add_column :events, :rating, :decimal,:precision => 3,:scale => 2
	  
  end
end
