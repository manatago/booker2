class FavoritesController < ApplicationController
    def create
        Favorite.create(:book_id=>params[:id],:user_id=>current_user.id)
        @book = Book.find(params[:id])
        #redirect_back fallback_location: root_path
        #return @book
    
    end
    
    def destroy
        favorite = Favorite.where(:book_id=>params[:id],:user_id=>current_user.id).first
        favorite.delete()
        @book = Book.find(params[:id])
        #redirect_back fallback_location: root_path
        #return @book
    end
    
    private
    
end
