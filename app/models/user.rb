class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :pages, dependent: :destroy
  has_many :expenses, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validate :email_domain

  def email_domain
    domain = email.split(".").last
    if !email.blank?
      errors.add(:email, "Invalid Domain") if domain != "coop"
    end
  end

end
