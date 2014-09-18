class CreatePlaceConnection < ActiveRecord::Migration
  def up
    create_table "place_connections", :force => true do |t|
		t.integer "place_a_id", :null => false
		t.integer "place_b_id", :null => false	
		t.integer "rel_type", default:0
	end
  end

  def down
	drop_table "place_connections"
  end
end
