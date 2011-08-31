class AuthorsUsersRelation < ActiveRecord::Migration
  def self.up
    create_table :authors_users, :id => false do |t|
      t.references :author
      t.references :user
    end
  end

  def self.down
    drop_table :authors_users
  end
end
