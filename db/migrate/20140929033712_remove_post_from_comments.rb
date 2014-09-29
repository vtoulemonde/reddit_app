class RemovePostFromComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
      t.remove_references :post, index: true
    end
  end
end
