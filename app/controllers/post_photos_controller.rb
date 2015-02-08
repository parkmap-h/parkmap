class PostPhotosController < ApplicationController
  def index
    @posts = PostPhoto.no_relation.reverse_order
  end

  def new
    @post = PostPhoto.new
  end

  def create
    @post = PostPhoto.new(post)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Park was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = PostPhoto.find(params[:id])
  end

  def edit
    @post = PostPhoto.find(params[:id])
  end

  def update
    @post = PostPhoto.find(params[:id])
    if @post.update(post)
      redirect_to action: :index
    else
      render :edit
    end
  end

  private
  def post
    params.require(:post_photo).permit(:photo,:note)
  end
end
