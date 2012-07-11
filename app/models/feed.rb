class Feed < ActiveRecord::Base
  belongs_to :status, :class_name => "Status", :foreign_key => "status_id"
end
