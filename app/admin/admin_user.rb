ActiveAdmin.register AdminUser do
  menu :parent => "All Users"
  index do
    column :email do |user|
      link_to user.email, admin_admin_user_path(user)
    end
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
