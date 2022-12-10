class UsersController < ApplicationController
    # before_action :authorize
    # skip_before_action :authorize, only: :create
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        return render json: {error: "Unauthorized"}, status: :unauthorized unless session.include? :user_id
        user = User.find(session[:user_id])
        render json: user, status: :created
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
