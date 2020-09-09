class UsersController < ApplicationController
# before_action :ensure_correct_user, only: [:edit, :update]
before_action :authenticate_user!
def show
  @user = User.find(params[:id])
  @books = @user.books
  @book = Book.new
end

def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book), notice: "You have created book successfully."
  else
    @books = Book.all
    render 'index'
  end
end

def index
  @users = User.all
  @book = Book.new
  @user = current_user
end

def edit
  @user = User.find(params[:id])
  if current_user != @user
    redirect_to user_path(current_user)
  end
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user), notice: "You have updated user successfully."
  else
    render "edit"
  end
end

def follows
end

def followers
end

private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_code, :city, :street)
end

 def screen_user
      unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
      end
    end

# def ensure_correct_user
#   @user = User.find(params[:id])
# unless @user == current_user
#   redirect_to user_path(current_user)
#  end
# end
end