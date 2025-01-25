class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :type
      t.integer :likes
      t.references :user
      t.jsonb :content, null: false

      t.timestamps
    end
  end
end
