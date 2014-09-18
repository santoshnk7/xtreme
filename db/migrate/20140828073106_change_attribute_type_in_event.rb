class ChangeAttributeTypeInEvent < ActiveRecord::Migration
  def up
	change_column :events, :name, :string
    change_column :events, :contact_number, :string
  end

  def down
	change_column :events, :name, :text
    change_column :events, :contact_number, :integer
  end
end
