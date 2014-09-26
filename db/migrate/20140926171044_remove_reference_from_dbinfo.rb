class RemoveReferenceFromDbinfo < ActiveRecord::Migration
  def up
    change_table(:dbinfos) do |t|
       t.remove :user_id
	end
  end

  def down
  end
end
