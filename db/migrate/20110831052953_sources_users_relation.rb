class SourcesUsersRelation < ActiveRecord::Migration
  def self.up
    create_table :sources_users, :id => false do |t|
      t.references :sources
      t.references :users
    end
  end

  def self.down
    drop_table :sources_users
  end
end
