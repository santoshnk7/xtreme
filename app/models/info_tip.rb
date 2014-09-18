require 'carrierwave/orm/activerecord'

class InfoTip < ActiveRecord::Base

belongs_to :category
attr_accessible :info_type, :message, :display_time, :close, :show_limit, :active
mount_uploader :featured_photo, PhotoUploader
end
