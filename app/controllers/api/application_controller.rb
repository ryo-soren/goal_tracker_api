class Api::ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from StandardError, with: :standard_error

    # def current_user
    #     @current_user ||= User.find_by_id session[:user_id]
    # end

    # helper_method :current_user

    def not_found
        render(
            json: {
                status: 404,
                type: "ActionController::RoutingError",
                message: "No route matches"
            },
            status: 404
        )
    end

    private

    def authenticate_user!
        puts "*****"
        puts current_user
        puts "***** api::ApplicationController#authenticate_user!"
        unless current_user.present?
            render(
                json: {
                    status: 401,
                    message: "Please sign in"
                },
                status: 401
            )
        end
    end
    
    protected

    def record_not_found(error)
        render(            
            json: {
                status: 404,
                type: error.class.to_s,
                message: error.message
            },
            status: 404
        )
    end

    def record_invalid(error)
        puts error
        invalid_record = error.record
        errors = invalid_record.errors.map do |error_object|
          {
            type: invalid_record.class.to_s,
            field: error_object.attribute,
            message: error_object.message
          }
        end
        render(
          json: {
            status: 422,
            errors: errors,
          },
          status: 422
        )
    end

    def standard_error(error)
        if error.is_a?(ActiveRecord::RecordInvalid)
            record_invalid(error)
        else
            logger.error error.full_message

            render(
                status: 500, #alias :internal_server_error
                json: {
                    errors: [
                        {
                            type: error.class.to_s,
                            message: error.message
                        }
                    ]
                } 
            )
        end
    end

end
