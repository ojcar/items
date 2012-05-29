class SubmittedItem < ActiveRecord::Base
  validates :url, :presence => true
  validates_length_of :url, :within => 5..200
  belongs_to :user
  
end
