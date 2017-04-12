class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		# #require is restrictive in that the params that get passed MUST contain a
		# key called 'post'. If it's not included then it fails and the user gets an
		# error. The #permit method is looser in that the params hash MAY have whatever
		# keys are in it. So in the 'create' case, it may have the :title and :description
		# keys. If it has only one or the other, no problem, but the hash won't accept
		# any other keys
	  @post = Post.new(post_params(:title, :description))
	  @post.save
	  redirect_to post_path(@post)
	end

	def update
	  @post = Post.find(params[:id])
	  @post.update(post_params(:title))
	  redirect_to post_path(@post)
	end

	def edit
	  @post = Post.find(params[:id])
	end

	private

	# - By creating a #post_params, we are able to make one change and both methods
	# will automatically be able to have the proper attributes whitelisted
	# - We pass the permitted fields in as *args; this keeps 'post_params'
	# pretty DRY while still allowing slightly different behavior depending on the
	# controller action
	def post_params(*args)
		params.require(:post).permit(*args)
	end
end
