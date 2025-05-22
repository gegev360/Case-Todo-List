# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        user.update(last_login: Time.zone.now)
        redirect_to root_path, notice: "Login realizado com sucesso!"
      else
        flash.now[:alert] = "Por favor, confirme seu e-mail antes de fazer login. Se não recebeu o e-mail de confirmação, você pode solicitar um novo clicando em 'Reenviar e-mail de confirmação'."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "E-mail ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end 