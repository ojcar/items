class User < ActiveRecord::Base
  acts_as_authentic
  has_and_belongs_to_many :roles
  
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
