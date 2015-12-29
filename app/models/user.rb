class User < ActiveRecord::Base
  has_many :Translate

  # before_validation do
  #   self.role = 1
  #   self.role = 0 if User.count == 0
  # end

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetMailer.reset_email(self).deliver_now
  end
end
