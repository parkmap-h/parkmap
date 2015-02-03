class PostPhotosController < ApplicationController
  def index
    @posts = PostPhoto.where.not(id: ParkPhoto.select(:post_photo_id))
      .reverse_order
  end

  def new
    @post = PostPhoto.new
  end

  def create
    @post = PostPhoto.new(post)
    if @post.save
      redirect_to @post, action: :show
    else
      render :new
    end
  end

  def show
    @post = PostPhoto.find(params[:id])
  end

  private
  def post
    params.require(:post_photo).permit(:photo,:note)
  end
end
