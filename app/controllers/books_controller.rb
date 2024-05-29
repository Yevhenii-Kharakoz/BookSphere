class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit]
  protect_from_forgery with: :null_session

  def index
    @books = Book.all
  end

  def new
    set_new_book
  end

  def search
    @genres = Genre.all
    @authors = Author.all
    book = Book.all
    if params
      if params[:author_id] and !params[:author_id].empty?
        author = Author.find(params[:author_id])
        book = author.books
      end
      if params[:status] and !params[:status].empty?
        book = book.where(status: params[:status])
      end
      if params[:title] and !params[:title].empty?
        book = book.where(title: params[:title])
      end
      if params[:count_pages] and !params[:count_pages].empty?
        book = book.where(count_pages: params[:count_pages])
      end
      if params[:genre_id] and !params[:genre_id].empty?
        genre = Genre.find(params[:genre_id])
        book = book.where(genre: genre)
      end
    end

    @result = book
  end

  def create
    @book = Book.add_book(book_params[:title], book_params[:descr], book_params[:count_pages], book_params[:status], book_params[:genre_id], book_params[:user_id], book_params[:author_ids])
    if @book
      current_user.increment!(:books_count)
      redirect_to @book
    else
      flash.now[:alert] = 'All fields must be filled!'
      set_new_book
      render :new
    end
  end

  def show
    @user = @book.user
    @genres = @book.genre
    @authors = @book.authors
  end

  def edit
    @authors = Author.all
    @genres = @book.genre
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    Book.delete_book_id(params[:id])
    redirect_to books_path
  end


  private

  def set_new_book
    @book = Book.new
    @genres = Genre.all
    @authors = Author.all
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :descr, :count_pages, :status, :genre_id, :user_id, author_ids: [])
  end
end
