class Groupinfo < ApplicationRecord

  has_and_belongs_to_many(:users)
  has_many :commitments





  before_destroy :remove_users

  private
  #Usuwanie użytkowników przypisanych do grupy przed jej usunięciem
  def remove_users
    self.users.clear
  end
end
