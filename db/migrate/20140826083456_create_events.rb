class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.text :description
      t.integer :contact_number
      t.datetime :Start_date_time
      t.datetime :end_date_time
      t.integer :grace_period
      t.boolean :year_round
      t.text :type
	  t.references :user, index: true

      t.timestamps
    end
  end
end
