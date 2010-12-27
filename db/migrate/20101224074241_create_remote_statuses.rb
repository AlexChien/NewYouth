class CreateRemoteStatuses < ActiveRecord::Migration
  def self.up
    create_table :remote_statuses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :remote_statuses
  end
end
