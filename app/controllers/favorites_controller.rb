class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    begin
      favorite = current_user.favorites.create!(book_id: @book.id)
    rescue ActiveRecord::RecordNotUnique
    end
  
    respond_to do |format| 
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy if favorite
    
    respond_to do |format|
      format.js
    end
  end
end
