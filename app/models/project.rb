class Project < ApplicationRecord
  enum :status, { pending: 0, active: 1, complete: 2, archived: 3 }

  # Associations
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true

  # Callbacks
  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= :pending
  end
end
