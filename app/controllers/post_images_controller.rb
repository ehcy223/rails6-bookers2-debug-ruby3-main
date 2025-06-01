class PostImagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path, notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  private

  def post_image_params
    params.require(:post_image).permit(:caption, :image)
  end
end
