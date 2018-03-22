class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :tasks
  
  validates_presence_of :first_name, :last_name

  scope :developers, -> { where(role: Role::DEVELOPER).order(:first_name) }

  module Role
    ADMIN = 'admin'
    DEVELOPER = 'developer'
  end

  def admin?
    role == Role::ADMIN
  end

  def developer?
    role == Role::DEVELOPER
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
