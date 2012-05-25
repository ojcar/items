class Item < ActiveRecord::Base
  validates :title, :presence => true
  validates :excerpt, :presence => true
  validates :url, :presence => true

  belongs_to :author
  belongs_to :category
  belongs_to :source
  belongs_to :user
  
end
