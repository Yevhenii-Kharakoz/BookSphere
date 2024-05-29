class DealsController < ApplicationController
  before_action :set_deal, only: %i[show edit]

  def index
    @deals = Deal.all
  end

  def show; end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.add_deal(genre_params[:title])
    if @genre
      redirect_to @genre
    else
      flash.now[:alert] = 'This genre already exists!'
      @genre = Genre.new
      render :new
    end
  end

  def edit; end

  def update
    @genre = Genre.update_genre(genre_params[:title], params[:id])
    if @genre
      redirect_to @genre
    else
      flash.now[:alert] = 'This genre already exists!'
      set_genre
      render :edit
    end
  end

  def destroy
    Genre.delete_genre_id(params[:id])
    redirect_to genres_path
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:deal).permit(:address, :date)
  end
end
