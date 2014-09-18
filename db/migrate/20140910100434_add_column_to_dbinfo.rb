class AddColumnToDbinfo < ActiveRecord::Migration
  def change
    add_column :dbinfos, :trial_period, :integer
  end
end
