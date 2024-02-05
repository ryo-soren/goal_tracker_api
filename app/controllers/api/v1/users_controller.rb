class Api::V1::UsersController < Api::ApplicationController
    def create
        user = User.new(user_params)
        user.save!
        session[:user_id] = user.id
        render json: current_user, status: 200
    end

    def update
        User.find(params[:id]).update(user_params)
        render json: current_user, status: 200
    end

    def destroy
        user = User.find(params[:id])
        session[:user_id] = nil
        user.destroy
        render json: {message: 'User deleted successfully'}, status: 200
    end

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :username,
            :email,
            :password,
            :password_confirmation
        )
    end
end
