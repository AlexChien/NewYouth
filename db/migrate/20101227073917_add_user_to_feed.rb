class AddUserToFeed < ActiveRecord::Migration
  def self.up
    add_column :feeds, :user, :string
  end

  def self.down
    remove_column :feeds, :user
  end
end
