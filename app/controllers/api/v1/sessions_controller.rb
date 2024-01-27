class Api::V1::SessionsController < Api::ApplicationController
    def create
        user = User.find_by(email: params[:username_or_email]) || User.find_by(username: params[:username_or_email])
        if user&.authenticate(params[:password])
            puts "$$$$$$"
            puts user.id
            puts "$$$$$$"
            session[:user_id] = user.id
            render(json: user)
            found_user = User.find_by_id session[:user_id]
            puts "$$$$$$"
            puts "session created #{found_user.username}"
            puts "$$$$$$"
        else
            render(
                json: {
                    status: 401,
                    message: "Invalid credentials"
                },
                status: 401
            )
        end
    end


    def destroy
        session[:user_id] = nil
        render json: {id: nil}
    end

    def current
        puts "$$$$$$"
        puts @current_user
        puts "$$$$$$"
        render(json: current_user)
    end
end
