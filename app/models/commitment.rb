class Commitment < ApplicationRecord
  # Relacja wiele do jednego z grupami
  belongs_to :groupinfo

  # Relacja wiele do wielu z użytkownikami
  has_and_belongs_to_many :users

  # Relacja jeden do wielu z rachunkami
  has_many :bills

  before_destroy :remove_users

  private
  #Usuwanie użytkowników przypisanych do grupy przed jej usunięciem
  def remove_users
    self.users.clear
  end
end
