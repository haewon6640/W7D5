class PostsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @subs = params[:post][:subs].map(&:to_i)
    if @post.save
      @subs.each do |sub_id|
        post_sub = PostSub.create(post_id: @post.id, sub_id: sub_id)
      end
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    @subs = []
    render :new
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @subs = @post.subs.map(&:id)
    if @post
      render :edit
    else
      redirect_to subs_url
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    @subs = params[:post][:subs].map(&:to_i)
    if @post && @post.author_id == current_user.id
      if @post.update(post_params)
        @post.post_subs.each do |ps|
          unless @subs.include?(ps.id)
            ps.destroy
          end
        end
        current_subs = @post.post_subs.map(&:sub_id)
        @subs.each do |sub_id|
          unless current_subs.include?(sub_id)
            PostSub.create(post_id: @post.id, sub_id: sub_id)
          end
        end
        redirect_to post_url(@post)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["unable to update"]
      redirect_to subs_url
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post && @post.author_id == current_user.id
      @post.destroy
      redirect_to sub_url(@post.sub_id)
    else
      redirect_back(fallback_location: subs_url)
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      render :show
    else
      redirect_to subs_url
    end
  end

  def post_params 
    params.require(:post).permit(:title, :url, :content, :subs)
  end
end
