class Alert < ActiveRecord::Base
  belongs_to :user
  has_one :warning
end
