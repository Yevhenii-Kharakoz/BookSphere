class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit]

  def index
    @reviews = Review.all
  end

  def show; end

  def new
    @review = Review.new
  end

  def create
    @review = Review.add_review(review_params[:title], review_params[:descr], review_params[:user_id])
    if @review
      redirect_to @review
    else
      flash.now[:alert] = 'This review already exists!'
      @review = Author.new
      render :new
    end
  end

  def edit; end

  def update
    @review = Review.update_review(params[:id], review_params[:title], review_params[:descr], review_params[:user_id])
    if @review
      redirect_to @review
    else
      flash.now[:alert] = 'This review already exists!'
      set_review
      render :edit
    end
  end

  def destroy
    Review.delete_review_id(params[:id])
    redirect_to reviews_path
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :descr, :user_id)
  end
end