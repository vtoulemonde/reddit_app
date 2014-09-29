class CommentsController < ApplicationController

	def new
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create comment_params
		if @comment.valid?
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:author, :text)
	end
end
