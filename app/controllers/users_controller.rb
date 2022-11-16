class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to user_url(@user.id)
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
