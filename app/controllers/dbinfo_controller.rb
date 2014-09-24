require 'net/http'
class DbinfoController < ApplicationController
def get_doe
    user=get_current_user params[:auth_token]
    if user.present?
	   dbinfo=Dbinfo.order("created_at").last
       render json: {"doe"=>dbinfo.doe}
	else
	 render json: {"status"=>"you need to sign up or sign in "},:status => 401
	end
end
end
