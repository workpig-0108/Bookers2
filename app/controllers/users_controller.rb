class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_current_user, {only: [:edit, :update]}

   def index
      @users = User.all
      @book = Book.new
      @user = current_user
   end

   def edit
      @user = User.find(params[:id])
   end

   def show
      @user = User.find(params[:id])
      @books = @user.books
      @book = Book.new
   end

   def update
        @user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice] = 'You have updated user successfully.'
        redirect_to user_path(@user.id)
    else
        render :edit
    end
   end

   def search
      if params[:name].present?
        @users = User.where('name LIKE ?', "%#{params[:name]}%")
      else
        @users = User.none
      end
    end

    def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
    end

    def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
    end

   private
   def  ensure_current_user
        @user = User.find(params[:id])
    if  @user != current_user
        redirect_to user_path(current_user)
    end
  end

   def user_params
        params.require(:user).permit(:profile_image, :name, :introduction)
   end
end
