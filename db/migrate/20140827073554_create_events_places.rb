class CreateEventsPlaces < ActiveRecord::Migration
  def change
    create_table :places_events, :id => false do |t|
      t.integer :place_id
      t.integer :event_id
    end
    add_index :places_events, :place_id
    add_index :places_events, :event_id
  end
end
