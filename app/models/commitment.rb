class Commitment < ApplicationRecord

  # Relacja wiele do jednego z grupami
  belongs_to :groupinfo
  # Relacja wiele do wielu z użytkownikami
  belongs_to :user, class_name: 'User'
  # Relacja jeden do wielu z rachunkami
  has_many :bills
  before_destroy :remove_users_groups

  private
        #Usuwanie użytkowników przypisanych do grupy przed jej usunięciem
  def remove_users_groups
    self.users.clear
    self.groupinfos.clear
  end
end
