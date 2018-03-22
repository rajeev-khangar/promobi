json.extract! task, :id, :title, :description, :project_id, :user_id, :status, :assigned_at, :started_at, :completed_at, :created_at, :updated_at
json.url task_url(task, format: :json)
