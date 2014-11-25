require 'net/http'
class PlaceController < ApplicationController

# GET /place
  def index
    user=get_current_user params[:auth_token]
    if user.present?
      if user.db_updated_at.nil?
        #return all places
        places=[]
        Place.where(status:"Approved").collect do |place|
          photo_thumb=place.featured_photo.url(:small_thumb)
          photo_thumb.at(0)=="/" ? photo_thumb="http://"+request.host_with_port+photo_thumb : photo_thumb
          encoded_string=Base64.strict_encode64(open(photo_thumb).read)
          places << place.as_json(:include=>[:categories=>{:only=>:id}],:only => [:id,:name,:location]).merge(:encoded_string => encoded_string)
        end
        if places.present?
          user.db_updated_at=Time.now
          user.save
        end
        render json: places
      else
        #return new/updated places
        updated_places=[]
        Place.where(status:"Approved").collect do |place|
          if user.db_updated_at < place.attrs_updated_at
            photo_thumb=place.featured_photo.url(:small_thumb)
            photo_thumb.at(0)=="/" ? photo_thumb="http://"+request.host_with_port+photo_thumb : photo_thumb
            encoded_string=Base64.strict_encode64(open(photo_thumb).read)
            updated_places << place.as_json(:include=>[:categories=>{:only=>:id}],:only => [:id,:name,:location]).merge(:encoded_string => encoded_string)
          end
        end
        if updated_places.present?
          user.db_updated_at=Time.now
          user.save
        end
        render json: updated_places
      end
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /place/:id
  def show
    user=get_current_user params[:auth_token]
    if user.present?
      unless Place.exists?(params[:id])
        render json: {'status'=>'Location Not Found'},:status => 404
      else
        place=Place.find(params[:id])
        poi=user.places.exists?(params[:id]).to_s
        render json: place.as_json(
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
            :only=>[:name,:location,:description,:actual_latitude,:actual_longitude,:rating,:contact_detail,:featured_photo]
        ).merge(:poi => poi)
      end
    else
      render json:{'status'=>'You need to sign in or sign up before continuing.'},:status => 401
    end
  end

# GET places/my_places
  def my_places
    user=get_current_user params[:auth_token]
    if user.present?
      render json: Place.where(status:"Approved",:user_id => user.id).as_json(:only => :id)
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# POST /place
  def create
    user=get_current_user params[:auth_token]
    if user.present?
      if params[:featured_photo][:file]
        photo = params[:featured_photo]
        uploaded_file_new = ::UploadedFile.new(Base64.decode64(photo[:file]), photo[:filename], photo[:content_type])
        uploaded_file = ActionDispatch::Http::UploadedFile.new(
      :tempfile => uploaded_file_new, :filename => photo[:filename], :original_filename => photo[:filename])
        params[:place][:featured_photo] = uploaded_file
      end
      if params[:contact_photo][:file]
        photo = params[:contact_photo]
        uploaded_file_new = ::UploadedFile.new(Base64.decode64(photo[:file]), photo[:filename], photo[:content_type])
        uploaded_file = ActionDispatch::Http::UploadedFile.new(
            :tempfile => uploaded_file_new, :filename => photo[:filename], :original_filename => photo[:filename])
        params[:place][:contact_photo] = uploaded_file
      end
      place = Place.new
      place.name=params[:place][:name]
      categories=params[:place][:categories]
      categories.each do |category|
        place.categories << Category.find(category[:id])
      end
      place.location=params[:place][:location]
      place.description=params[:place][:description]
      place.approx_latitude=params[:place][:approx_latitude]
      place.approx_longitude=params[:place][:approx_longitude]
      place.contact_photo=params[:place][:contact_photo]
      place.featured_photo=params[:place][:featured_photo]
      place.user=user
	
      if place.save
        render json: {"status"=>"Place Successfully Submitted. Awaiting Admin Approval."},:status => 201
      else
        render json: {"status"=>"Invalid or missing data."},:status => 422
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# GET places/find
  def find
    user=get_current_user params[:auth_token]
    if user.present?
      category_id=params[:category_id]
      distance_limit=params[:distance]
      latitude=params[:latitude]
      longitude=params[:longitude]
      name=params[:name]
      if distance_limit.present? && name.present?
        places=[]
        Category.find(category_id).places.where(:status=>"Approved").collect do |place|
          if place.name.downcase.include?(name)
            response=String.new
            open("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+latitude.to_s+","+longitude.to_s+"&destinations="+place.actual_latitude+","+place.actual_longitude+"&sensor=false"){|f|
              f.each_line {|line| response<<line}
            }
            json=JSON[response]
            distance=json['rows'][0]['elements'][0]['distance']['text']
            distance=(distance.gsub(' m','').to_f/1000).to_s + ' km' if distance.include?(' m')
            if distance.gsub(' km','').to_f <= distance_limit.to_f
              places << place.as_json(:only => :id).merge(:distance => distance)
            end
          end
        end
        render json: places.sort_by{|e| e[:distance].gsub(' km','').to_f}
      elsif distance_limit.present?
        places=[]
        Category.find(category_id).places.where(:status=>"Approved").collect do |place|
          response=String.new
          open("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+latitude.to_s+","+longitude.to_s+"&destinations="+place.actual_latitude+","+place.actual_longitude+"&sensor=false"){|f|
            f.each_line {|line| response<<line}
          }
          json=JSON[response]
          distance=json['rows'][0]['elements'][0]['distance']['text']
          distance=(distance.gsub(' m','').to_f/1000).to_s + ' km' if distance.include?(' m')
          if distance.gsub(' km','').to_f <= distance_limit.to_f
            places << place.as_json(:only => :id).merge(:distance => distance)
          end
        end
        render json: places.sort_by{|e| e[:distance].gsub(' km','').to_f}
      elsif name.present?
        places=[]
        Category.find(category_id).places.where(:status=>"Approved").collect do |place|
          places << place.as_json(:only => :id) if place.name.downcase.include?(name)
        end
        render json: places
      else
        render json: Category.find(category_id).places.where(:status=>"Approved").as_json(:only => :id)
      end
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET places/near_me_sort
  def near_me_sort
    user=get_current_user params[:auth_token]
    if user.present?
      latitude=params[:latitude]
      longitude=params[:longitude]
      category_id=params[:category_id]
      places=[]
      Category.find(category_id).places.where(:status=>"Approved").collect do |place|
        response=String.new
        open("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+latitude.to_s+","+longitude.to_s+"&destinations="+place.actual_latitude+","+place.actual_longitude+"&sensor=false"){|f|
          f.each_line {|line|
            response<<line
          }
        }
        json=JSON[response]

        if json['rows'][0]['elements'][0]['status'] == "OK"
           distance=json['rows'][0]['elements'][0]['distance']['text']
        else  
           distance = "0"
        end

        distance=(distance.gsub(' m','').to_f/1000).to_s + ' km' if distance.include?(' m')
        places << place.as_json(:only => :id).merge(:distance => distance)
      end
      render json: places.sort_by{|e| e[:distance].gsub(' km','').to_f}
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /places/top_rated_sort
  def top_rated_sort
    user=get_current_user params[:auth_token]
    if user.present?
      category_id=params[:category_id]
      render json: Category.find(category_id).places.where(:status=>"Approved").order("rating desc").as_json(:only => [:id, :rating])
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /places/near_me
  def near_me
    user=get_current_user params[:auth_token]
    if user.present?
      latitude=params[:latitude]
      longitude=params[:longitude]
      distance_limit=900.0
      places=[]
      Place.where(:status=>"Approved").collect do |place|
        response=String.new
        open("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+latitude.to_s+","+longitude.to_s+"&destinations="+place.actual_latitude+","+place.actual_longitude+"&sensor=false"){|f|
          f.each_line {|line|
            response<<line
          }
        }
        json=JSON[response]

        if json['rows'][0]['elements'][0]['status'] == "OK"
           distance=json['rows'][0]['elements'][0]['distance']['text']
        else  
           distance = "0"
        end

        distance=(distance.gsub(' m','').to_f/1000).to_s + ' km' if distance.include?(' m')
        if distance.gsub(' km','').to_f <= distance_limit
          places << place.as_json(:only => :id).merge(:distance => distance)
        end
      end
      render json: places.sort_by{|e| e[:distance].gsub(' km','').to_f}
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# POST /place_of_interest
  def place_of_interest
    user=get_current_user params[:auth_token]
    if user.present?
      if user.places.exists?(params[:place_id])
        render json: {"status"=>"Place already added to your favourites!"}
      else
        user.places << Place.find(params[:place_id])
        render json: {"status"=>"Place successfully added to your favourites."}
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# POST /place_of_interest_remove
  def place_of_interest_remove
    user=get_current_user params[:auth_token]
    if user.present?
      if user.places.exists?(params[:place_id])
        user.places.delete(Place.find(params[:place_id]))
        render json: {"status"=>"Place removed from your favourites."}
      else
        render json: {"status"=>"Place not present in your favourites!"}
      end
    else
      render json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end

# GET /places/places_of_interest
  def places_of_interest
    user=get_current_user params[:auth_token]
    if user.present?
      render json: user.places.as_json(:only => :id)
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end

# GET /reviews
  def reviews
    user=get_current_user params[:auth_token]
    if user.present?
      if(!Place.exists?(params[:id]))
        render json: {'status'=>'Location Not Found'},:status => 404
      else
        place=Place.find(params[:id])
        render json: place.as_json(:include=>[:reviews=>{:include=>[:user=>{:only=>:firstname}],:only=>:message}],
                                   :only=>:id)
      end
    else
      render json:{'status'=>'You need to sign in or sign up before continuing.'},:status => 401
    end
  end
end
