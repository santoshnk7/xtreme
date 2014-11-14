class Tip < ActiveRecord::Base
  belongs_to :place
  belongs_to :event
end
