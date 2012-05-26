class SubmittedItem < ActiveRecord::Base
  validates :url, :presence => true, :within => 5..200
  belongs_to :user
  
end
