# app/models/user.rb
class User < ApplicationRecord
  has_many :todo_lists, dependent: :destroy
  
  # Para criptografar a senha
  has_secure_password
  
  # Validações
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  # Callbacks
  before_create :generate_confirmation_token
  before_save :downcase_email
  
  # Métodos para confirmação de email
  def confirm_email
    self.email_confirmed = true
    self.confirmation_token = nil
    save
  end
  
  def send_confirmation_email
    # Envio de email vai ser implementado com ActionMailer
    UserMailer.confirmation_email(self).deliver_later
  end
  
  def regenerate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    save
  end
  
  # Métodos para redefinição de senha
  def generate_password_reset_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.zone.now
    save
  end
  
  def password_reset_expired?
    reset_password_sent_at < 2.hours.ago
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_later
  end
  
  private
  
  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
  
  def downcase_email
    self.email = email.downcase if email.present?
  end
end 