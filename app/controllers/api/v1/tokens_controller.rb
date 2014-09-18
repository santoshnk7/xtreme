class Api::V1::TokensController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    firstname= params[:username]
    mobile= params[:contact]
    country= params[:country]
    if request.format != :json
      render :status => 406, :json => {:message => "The request must be json"}
      return
    end

    if firstname.nil? or mobile.nil? or country.nil?
      render :status => 400,
             :json => {:message => "The request must contain username, contact and country."}
      return
    end

    u=User.where(:firstname => firstname, :mobile_no => mobile, :country => country).first
    if u.present?
      u.db_updated_at=nil
      u.save
      render :status => 200, :json => {:token => u.authentication_token}
      return
    end

    email=firstname+'@example.com'
    password='password'
    @user=User.create(
        :firstname=>firstname,
        :email=>email,
        :password=>password,
        :password_confirmation=>password,
        :mobile_no=>mobile,
        :country=>country
    )

    if @user.nil?
      logger.info("User registration failed.")
      render :status => 401, :json => {:message => "User registration failed"}
    else
      # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
      @user.ensure_authentication_token!
      render :status => 200, :json => {:token => @user.authentication_token}
    end

  end

  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status => 404, :json => {:message => "Invalid token."}
    else
      @user.reset_authentication_token!
      render :status => 200, :json => {:token => params[:id]}
    end
  end

end

