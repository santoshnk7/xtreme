require 'carrierwave/orm/activerecord'

class Event < ActiveRecord::Base
  has_many :warnings, :dependent => :destroy
  has_many :tips,     :dependent => :destroy
  has_many :ratings,  :dependent => :destroy
  has_many :reviews,  :dependent => :destroy
  belongs_to :user
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :places
  has_and_belongs_to_many :users
  
  has_and_belongs_to_many(:events,
    :join_table => "event_connections",
    :foreign_key => "parent_id",
    :association_foreign_key => "child_id")
	
  accepts_nested_attributes_for :warnings,:tips

  before_update :check_attributes_changed

  mount_uploader :featured_photo, PhotoUploader
  mount_uploader :contact_photo, LargeImageUploader

  scope :pending, where(:status => 'Pending')
  scope :approved,where(:status => 'Approved')
  scope :rejected,where(:status => 'Rejected')

  scope :categories_id_all_in, -> ids {
    ids.reduce(scoped) do |scope, id|
      subquery = Event.select('events.id').
          joins(:categories).
          where('categories.id = ?', id)
      scope.where("events.id IN (#{subquery.to_sql})")
    end
  }
  search_methods :categories_id_all_in
  
  scope :places_id_all_in, -> ids {
    ids.reduce(scoped) do |scope, id|
      subquery = Event.select('events.id').
          joins(:places).
          where('places.id = ?', id)
      scope.where("events.id IN (#{subquery.to_sql})")
    end
  }
  search_methods :places_id_all_in

  validates :name, presence: {:message => "Name Cannot be blank."}, length: {
      maximum: 255,
      too_short: "must have at least %{count} characters",
      too_long: "must have at most %{count} characters"
  }
  validates :contact_number, numericality: true
  validates :categories, :description, :user_id, presence: true

  private

  def check_attributes_changed
    if self.status=='Approved' && (self.name_changed? || self.location_changed? || self.featured_photo_changed?)
      self.attrs_updated_at=Time.now
    end
  end
end