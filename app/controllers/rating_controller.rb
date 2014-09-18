
class RatingController < ApplicationController

  def update
    user=get_current_user params[:auth_token]
    if user.present?
      params[:rating][:user_id]=user.id

      #Add or Update Rating
      rating = Rating.where(:place_id => params[:rating][:place_id],:user_id => params[:rating][:user_id]).first
      if rating.present?
         rating.update_attribute(:value,params[:rating][:value])
      else
          rating=Rating.create(params[:rating])
      end

      #Update rating of place
      rating.place.update_attribute(:rating,Rating.where(:place_id=>rating.place.id).average(:value))
      render  json: {"rating"=>rating.place.rating},:status => 200
    else
      render  json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end
end
