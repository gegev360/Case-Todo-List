# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create, :edit, :update], raise: false
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    
    if @user
      @user.generate_password_reset_token
      @user.send_password_reset_email
      redirect_to login_path, notice: "E-mail com instruções para redefinir sua senha foi enviado! Por favor, verifique sua caixa de entrada."
    else
      flash.now[:alert] = "E-mail não encontrado"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "não pode ficar em branco")
      render :edit, status: :unprocessable_entity
    elsif @user.update(user_params)
      @user.update(reset_password_token: nil, reset_password_sent_at: nil)
      
      # Verificar se o e-mail está confirmado antes de fazer login automático
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Senha redefinida com sucesso!"
      else
        redirect_to login_path, notice: "Senha redefinida com sucesso! Por favor, confirme seu e-mail antes de fazer login."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(reset_password_token: params[:token])
    unless @user
      redirect_to login_path, alert: "Link inválido ou expirado"
      return
    end
  end

  def valid_user
    unless @user
      redirect_to login_path, alert: "Link inválido ou expirado. Por favor, solicite um novo link de redefinição de senha."
      return
    end
    
    # Nota: Permitimos a redefinição de senha mesmo para usuários com e-mail não confirmado,
    # mas não permitimos o login automático após a redefinição (verificado no método update)
  end

  def check_expiration
    if @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Link de redefinição de senha expirado"
    end
  end
end 