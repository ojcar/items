class AuthenticationsController < ApplicationController
  before_filter :require_user, :only => [:destroy]
  
  def create
    omniauth = request.env['omniauth.auth']
    #authentication = Authentication.find_from_hash(omniauth)
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    if authentication
      flash[:info] = 'Te has registrado exitosamente'
      sign_in_and_redirect(authentication.user)
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      current_user.apply_omniauth(omniauth)
      current_user.save
      
      flash[:info] = 'Autenticacion exitosa'
      redirect_to home_url
    else
      user = User.new
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user.apply_omniauth(omniauth)
      
      if user.save
        flash[:info] = 'Success! User created.'
        sign_in_and_redirect_user(user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to 'signup_path'
      end
         
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    
    flash[:notice] = 'bye!'
    redirect_to authentications_url
  end
  
  def failure
    flash[:notice] = "Sin autorizacion"
    redirect_to root_url
  end
  
  private
  def sign_in_and_redirect(user)
    unless current_user
      user_session = UserSession.new(User.find_by_single_access_token(user.single_access_token))
      user_session.save
    end
    redirect_to home_path
  end
end
