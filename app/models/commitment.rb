class Commitment < ApplicationRecord
  # Relacja wiele do jednego z grupami
  belongs_to :groupinfo

  # Relacja wiele do wielu z użytkownikami
  has_and_belongs_to_many :users
end
