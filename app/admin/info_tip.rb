ActiveAdmin.register InfoTip do
config.per_page=8

filter :category
index do
    column :message
	column :featured_photo do |image|
      image_tag image.featured_photo.url(:thumb)
    end
    column :info_type
    column :category
	column :display_time
	column :close
	column :show_limit
	column :active
	
    default_actions
  end

  form do |f|
    f.inputs "InfoTip Details" do
      f.input :message
	  f.input :featured_photo,:as =>:file ,:hint => f.template.image_tag(f.object.featured_photo.url(:thumb))
      f.input :info_type, :as => :select, :collection => {
        "message" => 0, 
        "photo" => 1 }
      f.input :category
	  f.input :display_time
	  f.input :close, :as => :radio, :collection => {
        "True" => 0, 
        "False" => 1 }
	  f.input :show_limit
	  f.input :active, :as => :radio, :collection => {
        "True" => 0, 
        "False" => 1 }
    
	f.buttons
  end
end
  
  show do
    attributes_table do
     row :message
	  row :featured_photo do |image|
        image_tag image.featured_photo.url(:thumb)
      end
     row :info_type
     row :category
	 row :display_time
	 row :close
	 row :show_limit
	 row :active
    end
  end
end
