class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :place
      t.references :user
      t.text :message
      t.string :status ,default:'Pending'

      t.timestamps
    end
    add_index :reviews, :place_id
    add_index :reviews, :user_id
  end
end
