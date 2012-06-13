class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  
  has_many :authentications, :dependent => :destroy
  has_many :submitted_items
  has_many :items
  
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :sources
  
  acts_as_authentic do |c|
    c.login_field = :username
  end
  
  validates :username, :presence => true
  validate do |user|
    if user.new_record?
      user.errors.add(:password, "es requerido") if user.password.blank?
      user.errors.add(:password_confirmation, "es requerido") if user.password_confirmation.blank?
      user.errors.add(:password, "Son dos contrasenas distintas") if user.password != user.password_confirmation
    elsif !(!user.new_record? && user.password.blank? && user.password_confirmation.blank?)
      user.errors.add(:password, "es requerido") if user.password.blank?
      user.errors.add(:password_confirmation, "es requerido") if user.password_confirmation.blank?
      user.errors.add(:password, " deben coincidir.") if user.password != user.password_confirmation
      user.errors.add(:password, " deben tener 4 caracteres o mas") if user.password.length < 4 || user.password_confirmation.length < 4
    end
  end

  #not sure about this
  def self.create_from_hash(hash)
    #create(:username => hash['user_info']['name'])
    user = User.new(:username => hash['user_info']['name'].scan(/[a-zA-Z0-9_]/).to_s.downcase)
    user.save(false)
    user.reset_persistence_token!
    user
  end
  
  #fetch extra stuff from provider's profile
  def apply_omniauth(omniauth)
    
    case omniauth['provider']
    when 'facebook'
		  self.username = omniauth['user_info']['name']
		  self.email = omniauth['user_info']['email']
		  self.fullname = omniauth['user_info']['name']
		  self.first_name = omniauth['user_info']['first_name']
		  self.last_name = omniauth['user_info']['last_name']
		  self.url = omniauth['user_info']['urls']['Facebook']
		  self.website = omniauth['user_info']['Website']
		  self.description = omniauth['user_info']['description']
    when 'twitter'
		  self.username = omniauth['user_info']['nickname']
		  #self.email = omniauth['user_info']['name']
      self.fullname = omniauth['user_info']['name']
      # self.first_name = 
      # self.last_name =
      self.url = omniauth['user_info']['urls']['Twitter']
      self.website = omniauth['user_info']['urls']['Website']
      self.description = omniauth['user_info']['description']
    end
    
  end
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
end
