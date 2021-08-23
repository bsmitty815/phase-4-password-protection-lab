class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            # returns the logged in user
            # sets the user ID in the session
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # returns a 401 unauthorized response
            # does not set the user ID in the session
            # returns a 401 unauthorized response
            # does not set the user ID in the session
            render json: { error: "Invalid username or password" }, status: :unauthorized
        end
        
    end

    def destroy
        # returns no content
        # deletes the user ID from the session
        session.delete :user_id
        head :no_content
    end


end
