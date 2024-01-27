class Api::V1::GoalsController < Api::ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        render(
            json: @goals.order(:deadline),
            each_serializer: GoalSerializer
        )
    end
 
    def show
        render(json: @goal)
    end
    
    def create
        @goal.user = User.find(current_user.id)
        @goal.save!
        render(json: @goal)
    end

    def update
        
        if params[:completion]
            @completion = Completion.create(goal: @goal, user: current_user)
            if @goal.times == params[:done]
                @goal.successful += 1
                @goal.save!
            end
        end
        
        @goal.update(goal_params)
        @goal.save!
        render(json:{
            goal: @goal,
            completion: @completion
        })
    end

    def destroy
        goal = Goal.find(params[:id])
        goal.destroy
        render(
            json:{
                status: 200,
                message: "Goal #{goal.id} deleted successfully"
            }
        )
    end

    private

    def goal_params
        params.require(:goal).permit(
            :title,
            :description,
            :frequency,
            :times,
            :done,
            :successful,
            :unsuccessful,
            :deadline
        )
    end
end