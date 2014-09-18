class SetPlaceDefaultRating < ActiveRecord::Migration
  def up
    change_column_default :places, :rating, 0
  end

  def down
    change_column_default :places, :rating, nil
  end
end
