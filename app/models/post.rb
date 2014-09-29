class Post < ActiveRecord::Base
	has_many :comments, as: :parent
	
	validates :title, presence: true
end
