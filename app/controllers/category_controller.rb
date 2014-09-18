class CategoryController < ApplicationController

# GET /category
  def index
    records=[]
    host=request.host_with_port
    Category.all.each do |category|
      next if category.parent_id.nil? && !category.children.present?
      thumb=category.photo.url(:small_thumb)
      thumb.at(0)=="/" ? thumb="http://"+host+thumb : thumb
      encoded_string=Base64.strict_encode64(open(thumb).read)
      records << category.as_json(:only=>[:id,:name,:parent_id]).merge(:encoded_string => encoded_string)
    end
    render json: records
  end

end
