# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  enum :status, { pending: 0, active: 1, complete: 2, archived: 3 }

  # Associations
  has_many :comments, class_name: "Project::Comment", dependent: :destroy
  has_many :status_changes, class_name: "Project::StatusChange", dependent: :destroy
  has_many :events, -> { order(created_at: :asc) }, class_name: "Project::Event", dependent: :destroy
  has_many :users, through: :events, source: :eventable, source_type: "User"

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :status, presence: true

  # Callbacks
  before_validation :set_default_status, on: :create
  after_save :create_status_change!, if: :saved_change_to_status?

  private

  def set_default_status
    self.status ||= :pending
  end

  def create_status_change!
    return unless user = Current.user # Skip if no user context (i.e. tests or console)
    from_status = saved_change_to_status[0] || "pending"
    to_status   = saved_change_to_status[1]

    status_changes.create!(user:, from_status:, to_status:)
  end
end
