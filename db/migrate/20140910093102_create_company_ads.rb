class CreateCompanyAds < ActiveRecord::Migration
  def change
    create_table :company_ads do |t|
      t.integer :name
      t.string :message
      t.string :image
      t.string :path
      t.boolean :active, default: false
      t.date :start
      t.date :end

      t.timestamps
	 end
  end
end
