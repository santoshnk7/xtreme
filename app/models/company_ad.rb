require 'carrierwave/orm/activerecord'

class CompanyAd < ActiveRecord::Base

mount_uploader :ad_photo, PhotoUploader
end
