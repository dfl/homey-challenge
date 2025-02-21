class CreateProjectStatusChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :project_status_changes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :from_status, null: false
      t.string :to_status, null: false
      t.timestamps
    end
  end
end
