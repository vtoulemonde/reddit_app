class Post < ActiveRecord::Base
	has_many :comments, as: :parent
	
	validates :title, presence: true

	def Post.search(criteria)
		comments_search = Comment.where("text like ?", "%#{criteria}%")
		post_id_list = []
		comments_search.each { |comment| post_id_list << comment.get_parent_post.id }
		Post.where("title like ? or id in ( ? )", "%#{criteria}%", post_id_list).order('vote desc')
	end
end
