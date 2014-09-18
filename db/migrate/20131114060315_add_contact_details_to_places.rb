class AddContactDetailsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :contact_photo, :string
    add_column :places, :contact_detail, :string
  end
end
