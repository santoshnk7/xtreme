require 'carrierwave/orm/activerecord'

class Category < ActiveRecord::Base
  has_and_belongs_to_many :places
  has_and_belongs_to_many :events
  acts_as_nested_set
  has_many :info_tips

  mount_uploader :photo, PhotoUploader

  scope :high_level, where(:depth => 0)
  scope :leaves, where(:depth => 1)

  validates :name, presence: true, :uniqueness => {:case_sensitive => false}
end
