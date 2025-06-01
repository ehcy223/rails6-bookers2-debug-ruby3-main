class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.references :user, null: false, foreign_key: true
      t.string :caption

      t.timestamps
    end
  end
end
