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

  def add_user
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
    if @group.users << @user
      render json: @group, status: :ok
    else
      render json: @group.errors, status: :unprocessable_entity
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
    @groupinfo.destroy
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
