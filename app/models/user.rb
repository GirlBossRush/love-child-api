class User < ActiveRecord::Base
  private_attributes = [:password_digest, :role]

  # Relations
  has_many :stories
  # ----
end
