class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :category_id
      t.string  :title, null: false
      t.text    :body,  null: false
      t.string  :thumbnail, null: false

      t.timestamps
    end
  end
end
