class PostsController < ApplicationController

	def index
		@posts = Post.all.order('vote desc')
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.vote = 0
		if @post.save
            flash[:success] = "Your post has been created."
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
		@post.update post_params
		if @post.valid?
            flash[:success] = "Your post has been updated."
			redirect_to posts_path
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:success] = "Your post has been deleted."
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

	def search
		# Search on comments
		comments_search = Comment.select(:post_id).where("text like ?", "%#{params[:search][:criteria]}%")
		post_id_list = []
		comments_search.each do |comment|
			post_id_list << comment[:post_id]
		end
		# Search posts
		@posts = Post.where("title like ? or id in ( ? )", "%#{params[:search][:criteria]}%", post_id_list).order('vote desc')
		render 'index'
	end

	private

	def post_params
		params.require(:post).permit(:title, :link)
	end
end
