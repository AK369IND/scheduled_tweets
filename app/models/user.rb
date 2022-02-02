# email:string and password_digest:string are two attributes/columns in db that we added

# has_secure_password adds virtual attributes:
    # password:string virtual
    # password_confirmation:string virtual
# It matches these two attr and using bcrypt it hashes password and then stores that in password_digest

class User < ApplicationRecord
  has_many :twitter_accounts
  has_many :tweets

  has_secure_password

  validates :email, presence: true, format: { with: /[^@\s]+@[^@\s]/, message: 'Must be a valid email' }
  validates :password_digest, presence: true
  # cant add empty email and password to db
end
