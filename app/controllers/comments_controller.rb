class CommentsController < ApplicationController

	def new
		if params[:post_id]
			@parent = Post.find(params[:post_id])
		elsif
			@parent = Comment.find(params[:comment_id])
		end
		@comment = @parent.comments.build
	end

	def create
		if params[:post_id]
			@parent = Post.find(params[:post_id])
			post = @parent
		elsif
			@parent = Comment.find(params[:comment_id])
			post = @parent.get_parent_post
		end
		@comment = @parent.comments.create comment_params
		if @comment.valid?
			redirect_to post_path(post)
		else
			render 'new'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:author, :text)
	end
end
