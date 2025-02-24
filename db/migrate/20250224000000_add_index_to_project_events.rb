class AddIndexToProjectEvents < ActiveRecord::Migration[8.0]
  def change
    add_index :project_events, [:project_id, :created_at]
  end
end
