class ApplicationController < ActionController::Base
#  protect_from_forgery
  def get_current_user(auth_token)
    User.find_by_authentication_token(auth_token)
  end
end
