class Comment < ActiveRecord::Base

  belongs_to :parent, polymorphic: true
  has_many :comments, as: :parent

  validates :text, presence: true

  def get_parent_post
  	comment = self
  	while comment.parent_type == 'Comment'
  		comment = Comment.find(comment.parent_id)
  	end
  	Post.find(comment.parent_id)
  end

end
