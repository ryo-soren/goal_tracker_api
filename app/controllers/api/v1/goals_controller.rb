class Api::V1::GoalsController < Api::ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        Goal.check_and_update_unsuccessful
        render json: @goals.order(:deadline), status: 200
    end

    def show
        render json: @goal, status: 200
    end

    def create
        @goal = Goal.new(goal_params)
        @goal.user = current_user
        @goal.save!
        render json: @goal, status: 201, serializer: GoalSerializer
    end

    def update 
        if params[:completion]
            if @goal.times == params[:done]
                @goal.successful += 1
                @goal.save!
            end
            @completion = Completion.create(goal: @goal, user: current_user)
        end

        @goal.update(goal_params)
        @goal.save!
        render json: @goal, status: 200
    end

    def destroy
        @goal.destroy
        render json: {message: "Goal deleted"}, status: 200
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
