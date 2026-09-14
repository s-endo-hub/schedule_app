class PostsController < ApplicationController
  def index
    @posts = Post.order(start_date: :asc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "スケジュールを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: "スケジュールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "スケジュールを削除しました", status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :start_date, :end_date, :all_day)
  end
end