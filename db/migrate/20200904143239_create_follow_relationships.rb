class CreateFollowRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_relationships do |t|
      t.references :follower, foreign_key: { to_table: :users } #usersテーブルのidであることを指定
      t.references :following, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :follow_relationships, [:follower_id, :following_id], unique: true #←同じユーザーを２回フォローできなくする為
  end
end
