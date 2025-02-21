class CreateProjectStatusChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :project_status_changes do |t|
      t.timestamps
    end
  end
end
