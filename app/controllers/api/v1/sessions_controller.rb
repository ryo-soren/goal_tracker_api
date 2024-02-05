class Api::V1::SessionsController < Api::ApplicationController
     def create
        user = User.find_by(email: params[:username_or_email]) || User.find_by(username: params[:username_or_email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: current_user, status: 200
        else
            render json: {error: "Invalid username or password"}, status: 401
        end
    end


    def destroy
        session[:user_id] = nil
        render json: current_user, status: 200
    end

    def current
        render json: current_user, status: 200
    end
end
