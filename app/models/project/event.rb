# == Schema Information
#
# Table name: project_events
#
#  id             :integer          not null, primary key
#  eventable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  eventable_id   :integer          not null
#  project_id     :integer          not null
#
# Indexes
#
#  index_project_events_on_eventable                  (eventable_type,eventable_id)
#  index_project_events_on_project_id                 (project_id)
#  index_project_events_on_project_id_and_created_at  (project_id,created_at)
#
# Foreign Keys
#
#  project_id  (project_id => projects.id)
#
class Project::Event < ApplicationRecord
  # Associations
  belongs_to :eventable, polymorphic: true

  # Delegations
  delegate :project, :user, to: :eventable

  def to_partial_path # slight modification of convention for cleaner template organization
    "projects/event"
  end

  def associated_user
    eventable.is_a?(User) ? eventable : eventable.user
  end
end
