require 'net/http'
class EventController < ApplicationController

# GET /event
  def index
    user=get_current_user params[:auth_token]
    if user.present?
      if user.db_updated_at.nil?
        #return all events
       events=[]
        Event.where(status:"Approved").collect do |event|
          photo_thumb=event.featured_photo.url(:small_thumb)
          photo_thumb.at(0)=="/" ? photo_thumb="http://"+request.host_with_port+photo_thumb : photo_thumb
          encoded_string=Base64.strict_encode64(open(photo_thumb).read)
          events << event.as_json(:include=>[:categories=>{:only=>:id}],:only => [:id,:name,:location]).merge(:encoded_string => encoded_string)
        end
        if events.present?
          user.db_updated_at=Time.now
          user.save
        end
        render json: events
      else
        #return new/updated events
        updated_events=[]
		Event.where(status:"Approved").collect do |event|
          if user.db_updated_at < event.attrs_updated_at
            photo_thumb=event.featured_photo.url(:small_thumb)
            photo_thumb.at(0)=="/" ? photo_thumb="http://"+request.host_with_port+photo_thumb : photo_thumb
            encoded_string=Base64.strict_encode64(open(photo_thumb).read)
            updated_events << event.as_json(:include=>[:categories=>{:only=>:id}],:only => [:id,:name,:location]).merge(:encoded_string => encoded_string)
          end
        end
        if updated_events.present?
          user.db_updated_at=Time.now
          user.save
        end
        render json: updated_events
      end
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /event/:id
  def show
    user=get_current_user params[:auth_token]
    if user.present?
      unless Event.exists?(params[:id])
        render json: {'status'=>'Location Not Found'},:status => 404
      else
        event=Events.find(params[:id])
        poi=user.events.exists?(params[:id]).to_s
        render json: event.as_json(
            :include=>[
                {:categories=>{
                    :only=>:id
                  }
                },
                {:tips=>{
                    :only=>:message
                  }
                },
                {:warnings=>{
                    :only=>:message
                  }
                }
            ],
            :only=>[:name,:location,:description,:rating,:contact_detail,:featured_photo]
        ).merge(:poi => poi)
      end
    else
      render json:{'status'=>'You need to sign in or sign up before continuing.'},:status => 401
    end
  end

# GET events/my_events
  def my_events
    user=get_current_user params[:auth_token]
    if user.present?
      render json: Event.where(status:"Approved",:user_id => user.id).as_json(:only => :id)
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# POST /event
  def create
    user=get_current_user params[:auth_token]
    if user.present?
      if params[:featured_photo][:file]
        photo = params[:featured_photo]
        uploaded_file_new = ::UploadedFile.new(Base64.decode64(photo[:file]), photo[:filename], photo[:content_type])
        uploaded_file = ActionDispatch::Http::UploadedFile.new(
      :tempfile => uploaded_file_new, :filename => photo[:filename], :original_filename => photo[:filename])
        params[:event][:featured_photo] = uploaded_file
      end
      if params[:contact_photo][:file]
        photo = params[:contact_photo]
        uploaded_file_new = ::UploadedFile.new(Base64.decode64(photo[:file]), photo[:filename], photo[:content_type])
        uploaded_file = ActionDispatch::Http::UploadedFile.new(
            :tempfile => uploaded_file_new, :filename => photo[:filename], :original_filename => photo[:filename])
        params[:event][:contact_photo] = uploaded_file
      end
      event = Event.new
      event.name=params[:event][:name]
      categories=params[:event][:categories]
      categories.each do |category|
        event.categories << Category.find(category[:id])
      end
	  places=params[:event][:places]
      places.each do |place|
        event.places << Place.find(place[:id])
      end
      event.location=params[:event][:location]
      event.description=params[:event][:description]
      event.contact_photo=params[:event][:contact_photo]
      event.featured_photo=params[:event][:featured_photo]
      event.user=user
      if event.save
        render json: {"status"=>"Event Successfully Submitted. Awaiting Admin Approval."},:status => 201
      else
        render json: {"status"=>"Invalid or missing data."},:status => 422
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# GET events/find
  def find
    
  end

# GET events/near_me_sort
  def near_me_sort
    
  end

# GET /events/top_rated_sort
  def top_rated_sort
    user=get_current_user params[:auth_token]
    if user.present?
      category_id=params[:category_id]
      render json: Category.find(category_id).events.where(:status=>"Approved").order("rating desc").as_json(:only => [:id, :rating])
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /events/near_me
  def near_me
   
  end

# POST /event_of_interest
  def event_of_interest
    user=get_current_user params[:auth_token]
    if user.present?
      if user.events.exists?(params[:event_id])
        render json: {"status"=>"event already added to your favourites!"}
      else
        user.events << event.find(params[:event_id])
        render json: {"status"=>"event successfully added to your favourites."}
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# POST /event_of_interest_remove
  def event_of_interest_remove
    user=get_current_user params[:auth_token]
    if user.present?
      if user.events.exists?(params[:event_id])
        user.events.delete(event.find(params[:event_id]))
        render json: {"status"=>"event removed from your favourites."}
      else
        render json: {"status"=>"event not present in your favourites!"}
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# GET /events/events_of_interest
  def events_of_interest
    user=get_current_user params[:auth_token]
    if user.present?
      render json: user.events.as_json(:only => :id)
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /reviews
  def reviews
    user=get_current_user params[:auth_token]
    if user.present?
      if(!event.exists?(params[:id]))
        render json: {'status'=>'Location Not Found'},:status => 404
      else
        event=event.find(params[:id])
        render json: event.as_json(:include=>[:reviews=>{:include=>[:user=>{:only=>:firstname}],:only=>:message}],
                                   :only=>:id)
      end
    else
      render json:{'status'=>'You need to sign in or sign up before continuing.'},:status => 401
    end
  end
end
