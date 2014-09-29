class AddParentToComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
      t.references :parent, :polymorphic => true
    end
  end
end
