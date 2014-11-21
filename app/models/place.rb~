require 'carrierwave/orm/activerecord'

class Place < ActiveRecord::Base
  has_many :warnings, :dependent => :destroy
  has_many :tips,     :dependent => :destroy
  has_many :ratings,  :dependent => :destroy
  has_many :reviews,  :dependent => :destroy
  has_many :class_ratings, :dependent => :destroy

  belongs_to :user
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users
  has_and_belongs_to_many :events
  
 # has_and_belongs_to_many(:places,
 #   :join_table => "place_connections",
 #   :foreign_key => "parent_id",
 #   :association_foreign_key => "child_id")
  has_many :place_connections, :dependent => :destroy
  has_many :reverse_place_connections, :class_name => :PlaceConnection,
      :foreign_key => :place_b_id, :dependent => :destroy
  has_many :places, :through => :place_connections, :source => :place_b
  
  accepts_nested_attributes_for :warnings,:tips,:class_ratings,:place_connections

  before_create :check_coordinates
  before_update :check_attributes_changed

  mount_uploader :featured_photo, PhotoUploader
  mount_uploader :contact_photo, LargeImageUploader

  scope :pending, where(:status => 'Pending')
  scope :approved,where(:status => 'Approved')
  scope :rejected,where(:status => 'Rejected')
 
  scope :categories_id_all_in, -> ids {
    ids.reduce(scoped) do |scope, id|
      subquery = Place.select('places.id').
          joins(:categories).
          where('categories.id = ?', id)
      scope.where("places.id IN (#{subquery.to_sql})")
    end
  }
  search_methods :categories_id_all_in

  validates :name, presence: {:message => "Name Cannot be blank."}, length: {
      maximum: 255,
      too_short: "must have at least %{count} characters",
      too_long: "must have at most %{count} characters"
  }
  validates :categories, :description, :user_id, presence: true

  private
  def check_coordinates
    if !self.approx_latitude.present? && !self.approx_longitude.present?
        self.approx_latitude="15.479655"
        self.approx_longitude="73.780546"
    end
    self.actual_latitude=self.approx_latitude
    self.actual_longitude=self.approx_longitude
    self.attrs_updated_at=Time.now
  end

  def check_attributes_changed
    if self.status=='Approved' && (self.name_changed? || self.location_changed? || self.featured_photo_changed?)
      self.attrs_updated_at=Time.now
    end
  end
end