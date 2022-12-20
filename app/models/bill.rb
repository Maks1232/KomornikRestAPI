class Bill < ApplicationRecord
  enum :ispaid, [ yes: "yes", no: "no"]
end
