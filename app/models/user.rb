class User < ApplicationRecord
  has_and_belongs_to_many(:groupinfos)
  has_secure_password
end
