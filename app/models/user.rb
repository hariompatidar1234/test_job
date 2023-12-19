class User < ApplicationRecord
  validates :email, uniqueness: true
   validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :name, :email,presence: true
   validates :password,length: { minimum: 6 }
   has_many :urls

end
