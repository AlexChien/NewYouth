class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :default => "editor"
    add_index :users, :role
  end

  def self.down
    remove_index :users, :role
    remove_column :users, :role
  end
end