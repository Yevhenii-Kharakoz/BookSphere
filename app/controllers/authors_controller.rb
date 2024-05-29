class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit]
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:new, :create, :edit, :destroy]
  before_action :set_locale

  def set_locale
    if params[:locale].blank?
      redirect_to "/#{extract_locale_from_accept_language_header}"
    else
      I18n.locale = params[:locale]
    end
  end

  def index
    @authors = Author.all
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    @author = Author.add_author(author_params[:name])
    if @author
      redirect_to @author
    else
      flash.now[:alert] = 'This author already exists!'
      @author = Author.new
      render :new
    end
  end

  def edit; end

  def update
    @author = Author.update_author(params[:id], author_params[:name])
    if @author
      redirect_to @author
    else
      flash.now[:alert] = 'This author already exists!'
      set_author
      render :edit
    end
  end

  def destroy
    Author.delete_author_id(params[:id])
    redirect_to authors_path
  end

  def authorize_admin!
    unless current_user.admin?
      flash[:alert] = "Ви не маєте доступу до цієї сторінки."
      redirect_to root_path
    end
  end


  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end

