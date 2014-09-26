class PostsController < ApplicationController

	def index
		@posts = Post.all.order('created_at')
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.vote = 0
		if @post.save
			redirect_to posts_path
		else
			render 'new'
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
			redirect_to posts_path
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	def upvote
		@post = Post.find(params[:id])
		@post.vote += 1
		@post.save
		redirect_to posts_path
	end

	def downvote
		@post = Post.find(params[:id])
		@post.vote -= 1
		@post.save
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :link)
	end
end
