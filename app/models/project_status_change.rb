class ProjectStatusChange < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :from_status, :to_status, presence: true
end
