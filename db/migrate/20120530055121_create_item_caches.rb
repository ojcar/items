class CreateItemCaches < ActiveRecord::Migration
  def self.up
    create_table :item_caches do |t|
      t.text :content
      t.integer :item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_caches
  end
end
