class CreateEventConnection < ActiveRecord::Migration
  def up
    create_table "event_connections", :force => true, :id => false do |t|
		t.integer "parent_id", :null => false
		t.integer "child_id", :null => false	
	end
  end

  def down
	drop_table "place_connections"
  end
end
