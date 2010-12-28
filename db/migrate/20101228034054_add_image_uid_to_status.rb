class AddImageUidToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :profile_image_url, :string
    add_column :statuses, :remote_user_id, :integer
    add_column :statuses, :domain, :string
  end

  def self.down
    remove_column :statuses, :remote_user_id
    remove_column :statuses, :profile_image_url
    remove_column :statuses, :domain
  end
end
