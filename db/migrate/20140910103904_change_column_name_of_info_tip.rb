class ChangeColumnNameOfInfoTip < ActiveRecord::Migration
  def self.up
    rename_column :info_tips, :type, :info_type
	rename_column :info_tips, :image, :featured_photo
  end

  def self.down
    
  end
end
