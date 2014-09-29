class RemoveCommentFromComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
      t.remove_references :comment, index: true
    end
  end
end
