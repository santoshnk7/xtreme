ActiveAdmin.register Dbinfo do
config.per_page=8

filter :Feature_desc
filter :doe

index do
      column :s_version, :label => "Schema version"
	  column :s_desc, :label => "Schema Description"
      column :Min_cversion, :label => "Min Client version"
	  column :Max_cversion, :label => "Max Client version"
	  column :c_desc, :label => "Client Description"
	  column :doe, :label => "Date Of Expiry"
	  column :link_new, :label => "New for version link"
	  column :new_version, :label => "New Version"
	  column :feature_desc, :label => "Feature Description"
	  column :trial_period
	
    default_actions
  end

  form do |f|
    f.inputs "Database Info Details" do
      f.input :s_version, :label => "Schema version"
	  f.input :s_desc, :label => "Schema Description"
      f.input :Min_cversion, :label => "Min Client version"
	  f.input :Max_cversion, :label => "Max Client version"
	  f.input :c_desc, :label => "Client Description"
	  f.input :doe, :label => "Date Of Expiry"
	  f.input :link_new, :label => "New for version link"
	  f.input :new_version, :label => "New Version"
	  f.input :feature_desc, :label => "Feature Description"
	  f.input :trial_period
    
	f.buttons
  end
end
  
  show do
    attributes_table do
      row :s_version, :label => "Schema version"
	  row :s_desc, :label => "Schema Description"
      row :Min_cversion, :label => "Min Client version"
	  row :Max_cversion, :label => "Max Client version"
	  row :c_desc, :label => "Client Description"
	  row :doe, :label => "Date Of Expiry"
	  row :link_new, :label => "New for version link"
	  row :new_version, :label => "New Version"
	  row :feature_desc, :label => "Feature Description"
	  row :trial_period
    end
  end
end
