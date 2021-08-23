class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        # creates a new user
        # saves the password as password_digest to allow authentication
        # saves the user id in the session
        # returns the user as JSON
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            # does not save the user
            # returns a 422 unprocessable entity response
            render json: { error: "Invalid user" }, status: :unprocessable_entity
        end
    end

    def show
        # returns the first user when the first user is logged in
        # returns the second user when the second user is logged in
        # returns a 401 unauthorized response when no user is logged in
        
        user = User.find_by(id: session[:user_id])
        #render json: user_id
        if user
            render json: user
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
