class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.find(params[:id])
    BookAccess.create(:book_id=>@book.id)
  end

  def index
    @books = Book.left_outer_joins(:favorites)
              .select('books.*','sum(case when favorites.created_at >= "'+1.week.ago.to_s+'" then 1 else 0 end) as favorites_count')
              .group('books.id')
              #.order('favorites_count desc')
              
    if !params[:type]
      @books = @books.order('favorites_count desc')
    elsif params[:type] == 'new'
      @books = @books.order('books.created_at desc')
    elsif params[:type] == 'score'
      @books = @books.order('books.score desc')
    end
    
    if params[:tag] && params[:tag]!=''
      @books = @books.where('tag like ?',"%#{params[:tag]}%")
    end
    
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @book_tmp = @book
      @user = current_user
      flash.now[:notice] = 'error'
      render 'index'
      #redirect_back fallback_location: root_path
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
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
    params.require(:book).permit(:title,:body,:score,:tag)
  end
end
