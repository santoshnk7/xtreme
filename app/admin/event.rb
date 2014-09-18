ActiveAdmin.register Event do
 config.per_page=8

  scope :all, :default=>true
  scope :pending
  scope :approved
  scope :rejected

  filter :name
  filter :categories_id_all, :label => 'Categories', :as => :check_boxes, :collection => Category.where(:depth => 1)
  #filter :places_id_all, :label => 'Places', :as => :check_boxes

  index do
    column :featured_photo do |image|
      image_tag image.featured_photo.url(:thumb)
    end
    column :name
    column :categories do |event|
      categories=event.categories.collect{|category| category.name}
      categories.to_sentence
    end
	column :events do |event|
      events=event.events.collect{|event| event.name}
      events.to_sentence
    end
	column :places do |event|
      places=event.places.collect{|place| place.name}
      places.to_sentence
    end
    column :location
    column :status
    #column :rating do |event|
    #  event.rating > 0 ? event.rating.to_s : "Not Rated"
    #end
    column :author do |user|
      User.find_by_id(user.user_id).firstname unless user.user_id.nil?
    end
    default_actions
  end

  index :as => :grid, :columns => 4 do |event|
    table do
      tr td link_to image_tag(event.featured_photo.url(:thumb)), admin_event_path(event)
      tr td link_to event.name, admin_event_path(event), :class => "center"
    end
  end

  form do |f|
    f.inputs "Events Details" do
      f.input :name
	  f.input :contact_number
      f.input :featured_photo,:as =>:file ,:hint => f.template.image_tag(f.object.featured_photo.url(:thumb))
      f.input :categories, :as => :check_boxes, :collection => Category.where(:depth => 1)
	  f.input :places, :as => :check_boxes
	  f.input :Start_date_time
	  f.input :end_date_time
	  f.input :grace_period
	  f.input :year_round, :label =>"year round?", :as => :radio, :collection=>['true','false']
	  f.input :event_type, :label =>"Event Type", :as => :radio, :collection=>['Public','Private']
      f.input :location
      f.input :description
	  f.input :events, :as => :check_boxes , :collection => Event.where(:status => "Approved")
      f.input :user
      f.input :contact_photo,:as =>:file ,:hint => f.template.image_tag(f.object.contact_photo.url), :input_html => { :disabled => true }
      f.input :contact_detail
      f.has_many :tips do |tip|
        tip.input :message
      end
      f.has_many :warnings do |warning|
        warning.input :message
      end
      f.input :status, :as => :radio, :collection=>['Pending','Approved','Rejected']
    end
    f.buttons
  end

  show do
    attributes_table do
      row :name
      row :featured_photo do |image|
        image_tag image.featured_photo.url(:thumb)
      end
      row :categories do
        categories=event.categories.collect{|category| category.name}
        categories.to_sentence
      end
	  row :places do
        places=event.places.collect{|place| place.name}
        places.to_sentence
      end
      row :location
      row :rating
      row :status
      row :description
      row :contact_detail
      row :author, :sortable => :true do |user|
        User.find_by_id(user.user_id).firstname unless user.user_id.nil?
      end
      row :tips do
        tips=event.tips.collect{|tip| tip.message }
        tips.to_sentence
      end
      row :warnings do
        warnings =event.warnings.collect{|warning| warning.message }
        warnings.to_sentence
      end
    end
  end
end
