ActiveAdmin.register User do
  menu :parent => "All Users"

  filter :firstname
  filter :mobile_no
  filter :country

  index do
    column :firstname
    column :email
    column :mobile_no do |user|
      div :class => "right" do
        user.mobile_no
      end
    end
    column :country
    default_actions
  end

  show do
    attributes_table do
      row :firstname
      row :email
      row :mobile_no
      row :country
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      div do
        link_to "Back", admin_users_path, :class => "button"
      end
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :firstname
      f.input :email, :as=> :email
      f.input :password
      f.input :password_confirmation
      f.input :mobile_no
      f.input :country, :as => :string
    end
    f.buttons
  end
end
