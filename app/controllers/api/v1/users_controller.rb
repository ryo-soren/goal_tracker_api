class Api::V1::UsersController < Api::ApplicationController

    before_action :authenticate_user!, except: [:create]

    def show
        user = User.find(params[:id])
        render(json: user)
    end

    def create
        user = User.new(user_params)
        user.save!
        session[:user_id] = user.id
        render(
            json: {user_id: user.id}
        )
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render(
            json: {id: user.id}
        )
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render(
            json: {status: 200}
        )
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
