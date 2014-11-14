class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :reviews, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_and_belongs_to_many :places
  has_and_belongs_to_many :events

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :country, :mobile_no

  before_save :ensure_authentication_token
  validates :firstname, :presence => { :message => "First Name Required"}
  validates :mobile_no, numericality: true

  def name
    self.firstname
  end
end
