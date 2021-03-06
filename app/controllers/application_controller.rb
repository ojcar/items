class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "Necesitas registrarte para usar eso!"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_no_user
    logger.debug "ApplicationController::require_no_user"
    if current_user
      store_location
      flash[:notice] = "Estas registrado, necesitas salir para usar eso!"
      redirect_to :root
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def check_role(role)
    unless current_user && @current_user.has_role?(role)
      flash[:notice] = "No hay acceso"
      redirect_to :root
    end
  end
  
  def check_administrator_role
    check_role('Admin')
  end
  
  def check_editor_role
    check_role('Editor')
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
