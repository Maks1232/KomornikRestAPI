class GroupinfosController < ApplicationController
  before_action :set_groupinfo, only: %i[ show update destroy ]

  # GET /groupinfos
  def index
    @groupinfos = Groupinfo.all

    render json: @groupinfos
  end

  # GET /groupinfos/1
  def show
    render json: @groupinfo
  end

  # POST /groupinfos
  def create
    @groupinfo = Groupinfo.new(groupinfo_params)

    if @groupinfo.save
      render json: @groupinfo, status: :created, location: @groupinfo
    else
      render json: @groupinfo.errors, status: :unprocessable_entity
    end
  end

  # POST /groups/:id/users
  def add_user
    @groupinfo = Groupinfo.find(params[:id])
    user_id = JSON.parse(request.body.read)['user_id']
    @user = User.find_by(id: user_id)
      if @user.nil?
        render json: { error: 'User not found' }, status: :not_found
        else
        if @groupinfo.users << @user
          render json: "Przypisano użytkownika do grupy", status: :ok
        else
          render json: @groupinfo.errors, status: :unprocessable_entity
        end
      end
  end
  # remove /groups/:id/users
  def remove_user
    @groupinfo = Groupinfo.find(params[:id])
    user_id = JSON.parse(request.body.read)['user_id']
    @user = User.find_by(id: user_id)
    if @user.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      if @groupinfo.users.delete( @user )
        render json: "Usunięto użytkownika z grupy", status: :ok
      else
        render json: @groupinfo.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /groupinfos/1
  def update
    if @groupinfo.update(groupinfo_params)
      render json: @groupinfo
    else
      render json: @groupinfo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groupinfos/1
  def destroy
    @groupinfo = Groupinfo.find(params[:id])
    if @groupinfo.destroy
      render json: { message: 'Group deleted!' }, status: :ok
    else
      render json: @groupinfo.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groupinfo
      @groupinfo = Groupinfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groupinfo_params
      params.require(:groupinfo).permit(:groupname)
    end
end
