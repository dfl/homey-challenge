module Project::Concerns::Eventable
  extend ActiveSupport::Concern

  included do
    # Associations
    belongs_to :project
    belongs_to :user

    has_one :event, as: :eventable, dependent: :destroy

    # Callbacks
    after_create :create_event!
    after_create_commit :update_turbo_stream
  end

  def to_partial_path # slight modification of convention for better template organization
    name = self.class.name.demodulize.underscore
    "projects/#{name.pluralize}/#{name}"
  end

  private

  def create_event!
    project.events.create!(eventable: self)
  end

  def update_turbo_stream
      broadcast_append_to project,
        target: "timeline",
        partial: "projects/event",
        locals: { event: event }
  end
end
