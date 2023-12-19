class UsersController < ApplicationController
  # before_action :authorize_request, except: :create
    skip_before_action :authenticate_request, only: %i[index create login]
    before_action :find_user, only: %i[show update]
    # GET /users
    def index
      @users = User.all
      render json: @users, status: :ok
    end


    def show
      render json: @user, status: :ok
    end


    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end


    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def login
      if user = User.find_by(email: params[:email], password: params[:password])
        token = jwt_encode(user_id: user.id)
        render json: { message: 'Logged In Successfully..', token: token }
      else
        render json: { error: 'Please Check your Email And Password.....' }
      end
    end

    private

    def find_user
      @user = User.find_by_id(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(
        :avatar, :name, :username, :email, :password)
    end

end
