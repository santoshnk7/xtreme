class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :approx_latitude, :string, :null=>:no
      t.string :approx_longitude, :string, :null=>:no
      t.string :actual_latitude, :string, :null=>:no
      t.string :actual_longitude, :string, :null=>:no
      t.references :user, index: true
      t.string :status ,default:'Pending'
      t.string :featured_photo
      t.datetime :info_updated_at

      t.timestamps
    end
  end
end
