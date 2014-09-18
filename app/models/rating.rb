class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  belongs_to :event
end
