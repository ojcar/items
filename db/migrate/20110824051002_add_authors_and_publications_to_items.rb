class AddAuthorsAndPublicationsToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :author_id, :integer
    add_column :items, :source_id, :integer
  end

  def self.down
    remove_column :items, :source_id
    remove_column :items, :author_id
  end
end
