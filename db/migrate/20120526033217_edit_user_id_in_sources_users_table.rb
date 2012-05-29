class EditUserIdInSourcesUsersTable < ActiveRecord::Migration
  def self.up
    rename_column :sources_users, :users_id, :user_id
    rename_column :sources_users, :sources_id, :source_id
  end

  def self.down
    rename_column :sources_users, :user_id, :users_id
    rename_column :sources_users, :source_id, :sources_id
  end
end
