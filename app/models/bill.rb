class Bill < ApplicationRecord
  #enum :ispaid, [ yes: "yes", no: "no"]
  belongs_to :commitment
  belongs_to :user
end
