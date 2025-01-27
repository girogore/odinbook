class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :body
      t.jsonb :image_data
      t.timestamps
    end
  end
end
