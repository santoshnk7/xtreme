class ChangeColumnTypeCompanyAd < ActiveRecord::Migration
  def up
    change_column :company_ads, :name, :string
  end

  def down
    change_column :company_ads, :name, :integer
  end
end
