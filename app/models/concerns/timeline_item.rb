module TimelineItem
  extend ActiveSupport::Concern

  included do
    def timeline_date
      created_at
    end
  end
end
