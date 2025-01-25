class CreateFollowing < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.timestamps
      t.integer :user_id
      t.integer :followed_users_id
      t.string :status, null: false # "requested, approved, rejected"
    end
    add_index :followings, [ :user_id, :followed_users_id ], unique: true
  end
end
