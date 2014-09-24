class ReferenceUsersToDbinfo < ActiveRecord::Migration
  def up
  change_table :dbinfos do |t|
      t.references :user, index: true 
    end
  end

  def down
  end
end
