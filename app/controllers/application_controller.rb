class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Habilitar autenticação para todos os controllers
  before_action :authenticate_user
  
  # Tornar os métodos disponíveis nas views
  helper_method :current_user, :logged_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def authenticate_user
    unless logged_in?
      redirect_to login_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end
end
