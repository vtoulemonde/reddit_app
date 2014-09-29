class PostsController < ApplicationController

	helper_method :sort_column, :sort_direction

	def index
		@posts = Post.order(sort_column + ' ' + sort_direction)
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
		if(params[:search] != nil)
			@posts = Post.search(params[:search][:criteria])
		else
			#HELP if I sort a column on a search result, the search are no longer correct
			@posts = Post.order(sort_column + ' ' + sort_direction)
		end
		render 'index'
	end

	private

	def post_params
		params.require(:post).permit(:title, :link)
	end

	def sort_column  
		Post.column_names.include?(params[:sort]) ? params[:sort] : "vote"
	end  

	def sort_direction  
		%w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
	end 
end
