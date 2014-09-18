class CreatePlaceRelations < ActiveRecord::Migration
  def change
    create_table :place_relations do |t|
	  t.integer :parent_id, :references => :places
	  t.integer :child_id, :references => :places
	  t.string :relation_type
      t.timestamps
    end
	add_index :place_relations, :parent_id
    add_index :place_relations, :child_id
  end
end
