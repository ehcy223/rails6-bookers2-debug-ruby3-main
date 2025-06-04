class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id

    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js  # エラー時もJSで処理できるように
      end
      @book_comment = BookComment.new
      @user = @book.user
      render 'books/show'
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
    end
    redirect_back(fallback_location: books_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
