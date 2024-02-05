class Goal < ApplicationRecord
    belongs_to :user
    has_many :completions, dependent: :destroy
    
    before_validation :set_values_to_zero
  
    validates :times, numericality: {greater_than: 0, only_integer: true}
    validate :set_frequency
    validates_presence_of :title, :description, :deadline
  
    def self.check_and_update_unsuccessful
      Goal.all.find_each do |goal|
        if goal.deadline.present? && goal.deadline <= Time.current
          
          if goal.times > goal.done 
            goal.unsuccessful += 1
          end
  
          case goal.frequency
          when "daily"
            goal.deadline = Time.current + 1.day
          when "weekly"
            goal.deadline = Time.current + 1.week
          when "monthly"
            goal.deadline = Time.current + Time.current.end_of_month.day.days
          when "yearly"
            goal.deadline = Time.current + 1.year
          end
  
          goal.done = 0
          goal.save! 
        end
      end
    end
    
    private
  
    def set_frequency
      self.frequency ||= "one_time"
    end
  
    def set_values_to_zero
      self.successful ||= 0
      self.unsuccessful ||= 0
      self.done ||= 0
    end
  
end
  