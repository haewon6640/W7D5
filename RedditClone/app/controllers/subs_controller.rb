class SubsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      redirect_to subs_url
    end
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.creator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def update 
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit 
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    if @sub && @sub.creator_id == current_user.id 
      @sub.destroy
      redirect_to subs_url
    else
      flash[:errors] = ["Cannot delete the sub"]
      redirect_to subs_url
    end
  end

  private
  def sub_params 
    params.require(:sub).permit(:title, :description, :creator_id)
  end
end
