class Commitment < ApplicationRecord

  # Relacja wiele do jednego z grupami
  belongs_to :groupinfo
  # Relacja wiele do wielu z użytkownikami
  belongs_to :user, class_name: 'User'
  # Relacja jeden do wielu z rachunkami
  has_many :bills

  before_destroy :remove_all_bills
  private
  def remove_all_bills
    self.bills.destroy_all
  end
end
