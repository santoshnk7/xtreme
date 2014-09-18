class CreateEventsPlacesNew < ActiveRecord::Migration
  def change
    create_table :events_places, :id => false do |t|
      t.integer :event_id
	  t.integer :place_id
    end
    add_index :events_places, :event_id
    add_index :events_places, :place_id
  end
end
