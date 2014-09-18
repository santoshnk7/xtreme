class PlaceRelation < ActiveRecord::Base
  belongs_to :parent, :class_name => :Place
  belongs_to :child, :class_name => :Place
end
