class Project < ApplicationRecord
  enum :status, { pending: 0, active: 1, complete: 2, archived: 3 }

  # Associations
  has_many :comments, dependent: :destroy
  has_many :status_changes, class_name: 'ProjectStatusChange', dependent: :destroy
  has_many :users, through: :comments

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true

  # Callbacks
  before_validation :set_default_status, on: :create
  before_save :track_status_change, if: :status_changed?

  private

  def set_default_status
    self.status ||= :pending
  end

  def track_status_change
    return unless Current.user # Skip if no user context (like in tests/console)
    
    status_changes.build(
      user: Current.user,
      from_status: status_was || 'pending',
      to_status: status
    )
  end
end
