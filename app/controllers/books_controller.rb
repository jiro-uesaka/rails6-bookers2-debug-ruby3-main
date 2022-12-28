class BooksController < ApplicationController
  before_action :matching_id, only: [:edit]

  def show
    @post_book = Book.find(params[:id])
    @book = Book.new
    @user = User.find(@post_book.user_id)
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def matching_id
    @book = Book.find(params[:id])
    user_id = current_user.id
    book_id = @book.user.id
    unless user_id == book_id
      redirect_to books_path
    end
  end
end
