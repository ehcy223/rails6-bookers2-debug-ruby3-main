class RemovePostImageIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_reference :favorites, :post_image
  end
end
