class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: :destroy


  def index
    @users=User.paginate(page: params[:page])
  end


  def new
    @user=User.new
  end


  def show
    @user = User.find(params[:id])
  end


  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App, #{ @user[:name] }!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end


  def edit
      @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Profile updated"
      redirect_to @user
    else
      flash.now[:error]="Update failed"
      render 'edit'
    end
  end


  def destroy
    user=User.find(params[:id])
    user.destroy
    flash[:success]="#{user.name} (#{user.email}) is deleted successfully"
    store_current_location
    redirect_back_or(users_url)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  #before filter


  def signed_in_user
    #redirect_to signin_url, notice: "Please sign in." unless sign_in?
    if !signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in"
    end
  end


  def correct_user
    #if current_user != User.find_by_id(params[:id])
    #  flash[:error]="Sorry, you don't have the authority to edit this user's profile"
    #  redirect_to root_url
    #end
    @user = User.find_by_id(params[:id])
    unless current_user?(@user)
      flash[:error]="Sorry, you don't have the authority to edit this user's profile"
      redirect_to(root_url)
    end
  end


  def admin_user
    flash[:error]="You don't have the right to delete this user"
    redirect_to(root_url) if current_user.admin == false
  end




end
