class Task < ApplicationRecord
  include AASM

  belongs_to :project
  belongs_to :user, optional: true

  validates :title, presence: true
  
  before_save :assign_assigned_at

  module STATES
    COMPLETED   = 'completed'
    IN_PROGRESS = 'in_progress'
    NOT_STARTED = 'not_start'

    ALL_STATES = [NOT_STARTED, IN_PROGRESS, COMPLETED]
  end
  scope :completed, -> { where(status: STATES::COMPLETED) }
  scope :in_progress, -> { where(status: STATES::IN_PROGRESS) }
  scope :not_started, -> { where(status: STATES::NOT_STARTED) }    

  aasm column: 'status' do
    state :not_start, :initial => true
    state :in_progress
    state :completed

    event :run, after: :set_started_date do
     transitions :from => [:not_start, :completed], :to => :in_progress
    end

    event :stop, after: :set_completion_date do
      transitions :from => [:not_start, :in_progress], :to => :completed
    end

    event :not_started, after: :set_not_started do
      transitions :from => [:in_progress, :completed], :to => :not_start
    end
  end

  default_scope { order(created_at: :asc) }


  def change_status(_status)
    case _status
    when "not_start"
      not_started!
    when "in_progress"
      run!
    when "completed"
      stop!
    else
      raise 'Invalid transaction!!!!'
    end 
  end

  private

    def assign_assigned_at
      self.assigned_at = Time.now if self.user_id_changed?
    end

    def set_completion_date
      if completed?
        return update_attributes(completed_at: Time.now, started_at: Time.now) if completed_at.nil? && started_at.nil?
        update_attribute(:completed_at, Time.now) if completed_at.nil?
      end
    end

    def set_started_date
      if in_progress?
        update_attributes(started_at: Time.now, completed_at: nil)
      end
    end

    def set_not_started
      if not_start?
        update_attributes(started_at: nil, completed_at: nil)        
      end
    end    
end
