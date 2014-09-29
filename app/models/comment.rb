class Comment < ActiveRecord::Base
  # belongs_to :post

  belongs_to :parent, polymorphic: true
  has_many :comments, as: :parent

  # belongs_to :parent_comment, :class_name => "Comment"
  # has_many :subcomments, :class_name => "Comment", :foreign_key => "parent_comment_id"
  validates :text, presence: true

  def get_parent_post
  	comment = self
  	while comment.parent_type == 'Comment'
  		comment = Comment.find(comment.parent_id)
  	end
  	Post.find(comment.parent_id)
  end

end
