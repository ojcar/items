class ChangePublishedColumn < ActiveRecord::Migration
  def self.up
    rename_column :submitted_items, :published?, :published
  end

  def self.down
    rename_column :submitted_items, :published, :published?
  end
end
