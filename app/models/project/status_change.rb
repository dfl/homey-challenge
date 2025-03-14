# == Schema Information
#
# Table name: project_status_changes
#
#  id          :integer          not null, primary key
#  from_status :string           not null
#  to_status   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_project_status_changes_on_project_id  (project_id)
#  index_project_status_changes_on_user_id     (user_id)
#
# Foreign Keys
#
#  project_id  (project_id => projects.id)
#  user_id     (user_id => users.id)
#
class Project::StatusChange < ApplicationRecord
  # Concerns
  include Project::Concerns::Eventable

  # Associations
  belongs_to :project
  belongs_to :user

  # Validations
  validates :from_status, :to_status, presence: true
end
