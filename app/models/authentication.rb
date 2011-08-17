class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :provider, :uid, :presence => true
  validates_uniqueness_of :uid, :scope => :provider
end
