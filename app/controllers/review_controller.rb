class ReviewController < ApplicationController

  def create
    user=get_current_user params[:auth_token]
    if user.present?
      params[:review][:user_id]=user.id
      if Review.create(params[:review])
        render  json: {"status"=>"Review Submitted Successfully"},:status => 201
      else
        render  json: {"status"=>"Server encountered an error"},:status => 500
      end
    else
      render  json: {"status"=>"You need to sign in or sign up before continuing."},:status => 401
    end
  end
end
