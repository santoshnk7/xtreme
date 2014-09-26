class AddLimitToDbinfo < ActiveRecord::Migration
  def change
    change_table(:dbinfos) do |t|
       t.integer :msg_limit, default: 5
    end
  end
end
