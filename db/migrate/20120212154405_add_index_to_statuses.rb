class AddIndexToStatuses < ActiveRecord::Migration
  def self.up
    add_index :statuses, :created_at
    add_index :statuses, :updated_at
    add_index :statuses, :remote_created_at
    add_index :statuses, :state
    add_index :statuses, :domain
  end

  def self.down
    remove_index :statuses, :domain
    remove_index :statuses, :state
    remove_index :statuses, :column_name
    remove_index :statuses, :remote_created_at
    remove_index :statuses, :updated_at
  end
end