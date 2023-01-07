class Groupinfo < ApplicationRecord

  has_and_belongs_to_many(:users)
  has_many :commitments, dependent: :destroy

  before_destroy :remove_users_commitments

  private
  #Usuwanie użytkowników przypisanych do grupy przed jej usunięciem
  def remove_users_commitments
    self.users.clear
    self.commitments.destroy_all
  end
end
