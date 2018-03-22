class Project < ApplicationRecord
  validates :title, :description, presence: true
  validates_uniqueness_of :title
  
  has_many :tasks, dependent: :destroy
  has_many :projects_users, dependent: :destroy
  has_many :users, through: :projects_users

  accepts_nested_attributes_for :projects_users, allow_destroy: true, reject_if: proc {|attributes| attributes['user_id'].to_i == 0}  

  default_scope { order(created_at: :asc) }
end
