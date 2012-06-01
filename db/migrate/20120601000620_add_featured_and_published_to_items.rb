class AddFeaturedAndPublishedToItems < ActiveRecord::Migration
  def self.up
	add_column :items, :featured, :boolean, :default => false
	add_column :items, :published, :boolean, :default => true
  end

  def self.down
	remove_column :items, :featured
	remove_column :items, :published
  end
end
