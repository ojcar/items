class Item < ActiveRecord::Base
  validates :title, :presence => true
  validates :excerpt, :presence => true
  validates :url, :presence => true
  
  
end
