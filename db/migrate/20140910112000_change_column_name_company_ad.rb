class ChangeColumnNameCompanyAd < ActiveRecord::Migration
  def up
    rename_column :company_ads, :image, :ad_photo
	rename_column :company_ads, :start, :ad_start
	rename_column :company_ads, :end, :ad_end
  end

  def down
  end
end
