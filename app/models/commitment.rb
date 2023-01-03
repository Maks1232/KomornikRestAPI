class Commitment < ApplicationRecord
  validate :user_belongs_to_group

  # Relacja wiele do jednego z grupami
  belongs_to :groupinfo
  # Relacja wiele do wielu z użytkownikami
  has_and_belongs_to_many :users
  # Relacja jeden do wielu z rachunkami
  has_many :bills
  before_destroy :remove_users

  private
  def user_belongs_to_group
    commitment = Commitment.find(commitment_id)
    group = Groupinfo.find(commitment.groupinfo_id)
    unless group.users.exists?(user_id)
      errors.add(:user_id, "Musi należeć do grupy")
    end
  end

        #Usuwanie użytkowników przypisanych do grupy przed jej usunięciem
  def remove_users
    self.users.clear
  end
end
