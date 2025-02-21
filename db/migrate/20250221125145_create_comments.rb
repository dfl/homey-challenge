class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :text

      t.timestamps
    end
  end
end
