class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:edit, :update, :destroy]

  def index
    @sort_by = params[:sort_by]
    @name = params[:name]
    @age = params[:age]
    @books_count = params[:count]

    @users = User.all

    # Фильтрация
    @users = @users.where('name LIKE ?', "%#{@name}%") if @name.present?
    @users = @users.where(age: @age) if @age.present?
    @users = @users.where(books_count: @books_count) if @books_count.present?

    # Сортировка
    @users = case @sort_by
             when 'name_asc'
               @users.order(name: :asc)
             when 'name_desc'
               @users.order(name: :desc)
             when 'age_asc'
               @users.order(age: :asc)
             when 'age_desc'
               @users.order(age: :desc)
             when 'books_asc'
               @users.order(books_count: :asc)
             when 'books_desc'
               @users.order(books_count: :desc)
             else
               @users.order(:id)
             end
  end

  def show
    @books = Book.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.add_user(user_params[:name], user_params[:email], user_params[:city], user_params[:phone_number], user_params[:password])
    if @user
      redirect_to @user, notice: 'User was successfully created.'
    else
      flash.now[:alert] = 'This user already exists!'
      @user = User.new
      render :new
    end
  end

  def edit; end


  def update
    user = User.update_user(user_params[:name], user_params[:email], user_params[:city], user_params[:phone_number], user_params[:password], params[:id])
    if user
      redirect_to user
    else
      flash.now[:alert] = 'This user already exists!'
      set_user
      render :edit
    end
  end

  def destroy
    @user.books.destroy_all
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  def admin?
    self.admin
  end

  def profile
    @user = current_user
    @books = @user.books
  end

  private

  def authorize_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :city, :phone_number, :password)
  end
end
