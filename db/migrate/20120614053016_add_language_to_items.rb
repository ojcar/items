class AddLanguageToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :language, :string
  end

  def self.down
    remove_column :items, :language
  end
end
