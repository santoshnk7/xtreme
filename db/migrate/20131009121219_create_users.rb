class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :mobile_no

      t.timestamps
    end
  end
end
