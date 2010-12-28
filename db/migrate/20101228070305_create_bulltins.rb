class CreateBulltins < ActiveRecord::Migration
  def self.up
    create_table :bulltins do |t|
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :bulltins
  end
end
