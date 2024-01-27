class Goal < ApplicationRecord
    
    belongs_to :user
    has_many :completions, dependent: :destroy
    

    validates :title, :description, :deadline, presence: true
    validates :times, numericality: {greater_than: 0, only_integer: true}

    def self.check_and_update_unsuccessful
        goals = Goal.all
        goals.find_each do |goal|
            if goal.deadline.present? && goal.deadline <= Time.current
                if goal.times > goal.done 
                    goal.unsuccessful += 1
                end
                frequency = goal.frequency
                case frequency
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
            end 
            goal.save!
        end
    end
end
