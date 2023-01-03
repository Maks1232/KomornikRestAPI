class Bill < ApplicationRecord

  belongs_to :commitment
  belongs_to :user

end
