class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :place
      t.decimal :value, :precision => 3, :scale =>2

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :place_id
  end
end
