require 'net/http'
class AlertController < ApplicationController

  def get_alerts
    user=get_current_user params[:auth_token]
    if user.present?
      latitude=params[:latitude]
      longitude=params[:longitude]
      places=Place.where(:status=>"Approved").collect do |place|
        response=String.new
        open("http://maps.googleapis.com/maps/api/distancematrix/json?origins="+latitude.to_s+","+longitude.to_s+"&destinations="+place.actual_latitude+","+place.actual_longitude+"&sensor=false"){|f|
        f.each_line {|line|
            response<<line
          }
        }
        json=JSON[response]
        distance=json['rows'][0]['elements'][0]['distance']['text']
        place.id if distance.gsub(' km','').to_f<5
      end
      list=[]
      warnings=Warning.where('place_id in (?)', places.compact)
      warnings.each do|warning|
        conditions={
            :user_id=>user.id,
            :warning_id => warning.id
        }
        alert=Alert.where(conditions).first
        if alert.present?
          if warning.updated_at > alert.updated_at
            alert.updated_at=Time.now
            alert.save
            list<<warning
          end
        else
          Alert.create(conditions)
          list<<warning
        end
      end
      render json: list
    else
      render json: ["You need to sign in or sign up before continuing."],:status => 401
    end
  end
end
