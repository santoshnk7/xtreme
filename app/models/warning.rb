class Warning < ActiveRecord::Base
  belongs_to :place
  belongs_to :event

  def as_json(options={})
    {
        :title=>"Alert",
        :message=>self.message,
        :location=>self.place.name
    }
  end
end
