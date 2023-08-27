class BookCommentsController < ApplicationController
  def create
    
    BookComment.create(book_comment_params.merge(:book_id=>params[:book_id],:user_id=>current_user.id))
    redirect_back fallback_location: root_path
  end
  
  def destroy
    book_comment = BookComment.find(params[:id])
    if book_comment.user.id != current_user.id
      redirect_to root_path and return
    end
    book_comment.delete()
    redirect_back fallback_location: root_path
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
