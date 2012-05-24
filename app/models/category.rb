class Category < ActiveRecord::Base
  has_many :items
  
  validates :name, :presence => true, :uniqueness => true
  # validates_presence_of :name
  # validates_uniqueness_of :name
end
