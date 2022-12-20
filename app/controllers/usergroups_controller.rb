class UsergroupsController < ApplicationController
  before_action :set_usergroup, only: %i[ show update destroy ]

  # GET /usergroups
  def index
    @usergroups = Usergroup.all

    render json: @usergroups
  end

  # GET /usergroups/1
  def show
    render json: @usergroup
  end

  # POST /usergroups
  def create
    @usergroup = Usergroup.new(usergroup_params)

    if @usergroup.save
      render json: @usergroup, status: :created, location: @usergroup
    else
      render json: @usergroup.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /usergroups/1
  def update
    if @usergroup.update(usergroup_params)
      render json: @usergroup
    else
      render json: @usergroup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /usergroups/1
  def destroy
    @usergroup.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usergroup
      @usergroup = Usergroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usergroup_params
      params.fetch(:usergroup, {})
    end
end
