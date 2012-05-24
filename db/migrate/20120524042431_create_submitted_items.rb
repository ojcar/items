class CreateSubmittedItems < ActiveRecord::Migration
  def self.up
    create_table :submitted_items do |t|
      t.string :url
      t.integer :user_id
      t.boolean :published?

      t.timestamps
    end
  end

  def self.down
    drop_table :submitted_items
  end
end
