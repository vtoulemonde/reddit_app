class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :author
      t.references :post, index: true
      t.references :comment, index: true

      t.timestamps
    end
  end
end
