class AddColumnsToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :remote_created_at, :datetime
    add_column :statuses, :remote_id, :integer
    add_column :statuses, :state, :string
  end

  def self.down
    remove_column :statuses, :state
    remove_column :statuses, :remote_id
    remove_column :statuses, :remote_created_at
  end
end
