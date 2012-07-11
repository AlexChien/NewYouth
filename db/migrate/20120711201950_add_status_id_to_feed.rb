class AddStatusIdToFeed < ActiveRecord::Migration
  def self.up
    add_column :feeds, :status_id, :integer
  end

  def self.down
    remove_column :feeds, :status_id
  end
end
