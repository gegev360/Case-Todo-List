# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create, :confirm_email, :resend_confirmation]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.send_confirmation_email
      redirect_to root_path, notice: "Cadastro realizado com sucesso! Por favor, confirme seu e-mail."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update(user_update_params)
      redirect_to user_path, notice: "Perfil atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def confirm_email
    user = User.find_by(confirmation_token: params[:token])
    
    if user
      user.confirm_email
      redirect_to login_path, notice: "E-mail confirmado com sucesso! Agora você pode fazer login."
    else
      redirect_to root_path, alert: "Link de confirmação inválido ou expirado."
    end
  end
  
  def resend_confirmation
    @user = User.find_by(email: params[:email])
    
    if @user && !@user.email_confirmed
      # Gerar novo token de confirmação
      @user.regenerate_confirmation_token
      @user.send_confirmation_email
      redirect_to login_path, notice: "Um novo e-mail de confirmação foi enviado para #{@user.email}."
    else
      redirect_to login_path, alert: "Não foi possível enviar o e-mail de confirmação. Verifique se o e-mail está correto ou se a conta já foi confirmada."
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
  
  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end
end 