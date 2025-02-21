class Comment < ApplicationRecord
  include TimelineItem
  
  belongs_to :project
  belongs_to :user

  validates :text, presence: true

  broadcasts_to :project, inserts_by: :prepend, target: "comments"
end
