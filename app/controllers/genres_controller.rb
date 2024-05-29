class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def show; end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: 'Genre was successfully created.'
    else
      flash.now[:alert] = 'This genre already exists!'
      render :new
    end
  end

  def edit; end

  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: 'Genre was successfully updated.'
    else
      flash.now[:alert] = 'This genre already exists!'
      render :edit
    end
  end

  def destroy
    Genre.delete_genre_id(params[:id])
    redirect_to genres_path, notice: 'Genre was successfully destroyed.'
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:title)
  end

  def authorize_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
