module TimelineItem
  extend ActiveSupport::Concern

  included do
    # this isn't essential but a placeholder for any future shared logic
    def timeline_date
      created_at
    end
  end
end
