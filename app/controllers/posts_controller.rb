class PostsController < ApplicationController
  # This is the one you were briefly mentioning about a before action on a method that should be only for show page
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = current_user.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find_by(id: params[:id])
    if current_user && current_user.id == @post.user.id
      @post
    else
      flash.now[:alert] = "Post #{@post.id} not found!"
      @posts = current_user.posts
      render "index"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by(id: params[:id])
    if current_user && current_user.id == @post.user.id
      @post
    else
      flash.now[:alert] = "Post #{@post.id} not found!"
      @posts = current_user.posts
      render "index"
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    # This is needed so that the post belongs to the current user
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(current_user, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: user_post_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
