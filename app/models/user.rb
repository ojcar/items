class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :authentications, :dependent => :destroy
  has_many :submitted_items
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :sources
  
  acts_as_authentic do |c|
    c.login_field = :username
  end
  
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
    self.email = omniauth['user_info']['email']
    
    case omniauth['provider']
    when 'facebook'
    when 'twitter'
    end
    
  end
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
end
