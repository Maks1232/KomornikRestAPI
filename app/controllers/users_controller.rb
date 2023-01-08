class UsersController < ApplicationController
  before_action :authentication, except: [:create, :login]
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_user_data({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :created
    else
      render json: { error: 'Invalid username or password or mail' }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(login: user_params[:login])

    if @user && @user.authenticate(user_params[:password])
      token = encode_user_data({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password or mail' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    if @current_user == @user
      @user.update(user_params)
      render json: @user
    else
      render json: { message: 'Wrong token passed! You can update only your own account.' }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    if @current_user == @user
      @user.destroy
      render json: { message: 'User deleted!' }, status: :ok
    else
      render json: { message: 'Wrong token passed! You can delete only your own account.' }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :login, :password, :mail)
    end
end
