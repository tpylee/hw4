class User < ApplicationRecord
  has_secure_password  # Enables password authentication using Bcrypt
end