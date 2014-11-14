ActiveAdmin.register CompanyAd do
active_admin_importable
config.per_page=8
filter :name
index do
    column :ad_photo do |image|
      image_tag image.ad_photo.url(:thumb)
    end
	column :name
    column :message
	column :path
	column :active
	column :ad_start
	column :ad_end
	
    default_actions
  end

  form do |f|
    f.inputs "company Ad Details" do
      f.input :name
      f.input :message
	  f.input :ad_photo,:as =>:file ,:hint => f.template.image_tag(f.object.ad_photo.url(:thumb))
	  f.input :path
	  f.input :active
	  f.input :ad_start
	  f.input :ad_end
    
	f.buttons
  end
end
  
  show do
    attributes_table do
      row :ad_photo do |image|
      image_tag image.ad_photo.url(:thumb)
      end
	  row :name
      row :message
	  row :path
	  row :active
	  row :ad_start
	  row :ad_end
    end
  end
end
