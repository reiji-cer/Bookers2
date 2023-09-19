class BooksController < ApplicationController
  def index
    @self_user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to  book_path(@book.id)
    else
      @self_user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @self_user = current_user
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    is_matching_login_book_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_book_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to  books_path
    end
  end

end
