class SearchesController < ApplicationController
  def search
    @model = params[:model]        # "user" または "book"
    @content = params[:content]    # 検索ワード
    @method = params[:method]      # "perfect", "forward", "backward", "partial"

    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == "user"
      if method == "perfect"
        User.where(name: content)
      elsif method == "forward"
        User.where("name LIKE ?", "#{content}%")
      elsif method == "backward"
        User.where("name LIKE ?", "%#{content}")
      else
        User.where("name LIKE ?", "%#{content}%")
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      elsif method == "forward"
        Book.where("title LIKE ?", "#{content}%")
      elsif method == "backward"
        Book.where("title LIKE ?", "%#{content}")
      else
        Book.where("title LIKE ?", "%#{content}%")
      end
    end
  end
end
