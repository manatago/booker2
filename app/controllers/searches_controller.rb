class SearchesController < ApplicationController
  def search
    pre_after = {"完全一致"=>["",""],"前方一致"=>["","%"],"後方一致"=>["%",""],"部分一致"=>["%","%"]}
    case params[:column]
      when "User"
        @books = Book.where(:user_id=>User.where('name like ?',pre_after[params[:type]][0]+"#{params[:word]}"+pre_after[params[:type]][1]).pluck(:id))  
      when "Comment"
        @books = Book.joins(:book_comments).where("book_comments.comment LIKE ?",pre_after[params[:type]][0]+"#{params[:word]}"+pre_after[params[:type]][1])
      else
        
    end
  end
end
