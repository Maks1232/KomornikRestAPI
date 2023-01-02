class Groupinfo < ApplicationRecord
  #has_and_belongs_to_many(:users)

  has_many :groupmembers
  has_many :users, through: :groupmembers
end
