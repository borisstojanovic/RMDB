class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!
  before_action :is_authorized!, only: [:index, :destroy]

  def index
    @per_page = params[:per_page]?params[:per_page]:5
    @users = User.search_user(params[:search]).order('created_at DESC').paginate(page: params[:page], per_page: @per_page)
  end

  def show; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
  def set_user
    begin
      @user = User.find(params[:id])
    rescue => e
      redirect_back fallback_location: root_path
    end
  end
end
