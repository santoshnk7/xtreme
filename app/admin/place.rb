ActiveAdmin.register Place do
active_admin_importable
  config.per_page=8

  scope :all, :default=>true
  scope :pending
  scope :approved
  scope :rejected

  filter :name
  filter :categories_id_all, :label => 'Categories', :as => :check_boxes, :collection => Category.where(:depth => 1)

  index do
    column :featured_photo do |image|
      image_tag image.featured_photo.url(:thumb)
    end
    column :name
    column :categories do |place|
      categories=place.categories.collect{|category| category.name}
      categories.to_sentence
    end
	column :places do |place|
      places=place.places.collect{|place| place.name}
      places.to_sentence
    end
    column :location
    column :status
    column :rating do |place|
      place.rating > 0 ? place.rating.to_s : "Not Rated"
    end
    column :author do |user|
      User.find_by_id(user.user_id).firstname unless user.user_id.nil?
    end
    default_actions
  end

  index :as => :grid, :columns => 4 do |place|
    table do
      tr td link_to image_tag(place.featured_photo.url(:thumb)), admin_place_path(place)
      tr td link_to place.name, admin_place_path(place), :class => "center"
    end
  end

  form do |f|
    f.inputs "Place Details" do
      f.input :name
      f.input :featured_photo, :as =>:file ,:hint => f.template.image_tag(f.object.featured_photo.url(:thumb))
      f.input :categories, :as => :check_boxes, :collection => Category.where(:depth => 1)
      f.input :location
      f.input :description
      f.input :user
      f.input :contact_photo,:as =>:file ,:hint => f.template.image_tag(f.object.contact_photo.url), :input_html => { :disabled => true }
      f.input :contact_detail
	  f.has_many :place_connections do |place_connection| 
		place_connection.input :place_b_id, :as => :select , :collection => Place.where(:status => "Approved")
		place_connection.input :rel_type, :as => :select, :collection => {
        "Paid" => 1, 
        "Functionality" => 2,
        "Distance" => 3		}
	  end
	  f.has_many :tips do |tip|
        tip.input :message
      end
      f.has_many :warnings do |warning|
        warning.input :message
      end
	  
	  f.input :cleanliness, :as => :select, :collection => [1,2,3,4,5]
	  f.input :p_type, :as => :radio, :collection => {
        "Public" => 0, 
        "Private" => 1 }
	  f.input :star_rating, :as => :select, :collection => [1,2,3,4,5]
	  f.input :rest_type, :as => :radio, :collection => { 
        "Veg" => 0, 
        "Non Veg" => 1,
        "Both" => 2,
		"Undefined" => 3 }
      f.input :approx_latitude , :input_html => { :disabled => true }
      f.input :approx_longitude, :input_html => { :disabled => true }
      f.input :actual_latitude , :input_html => { :disabled => true }
      f.input :actual_longitude, :input_html => { :disabled => true }
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
        categories=place.categories.collect{|category| category.name}
        categories.to_sentence
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
        tips=place.tips.collect{|tip| tip.message }
        tips.to_sentence
      end
      row :warnings do
        warnings =place.warnings.collect{|warning| warning.message }
        warnings.to_sentence
      end
      div do
        h5 b "CURRENT LOCATION"
        p=Place.find_by_id(params[:id])
        render :partial => 'view', :locals => {:p => p}
        table do
          tr do
            td :width => "490px" do
              link_to "Verify Location", verify_location_admin_place_url(p), :class => "button"
            end
            td link_to "Back", admin_places_path, :class => "button"
          end
        end
      end
    end
  end

  member_action :verify_location do
   @loc=Place.find_by_id(params[:id])
  end

  member_action :update_location, :update => :put do
    location=Place.find_by_id(params[:id])
    location.actual_latitude=params[:latitude]
    location.actual_longitude=params[:longitude]
    location.save!
    redirect_to :back
  end
end
