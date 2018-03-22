class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status
      t.datetime :assigned_at
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
