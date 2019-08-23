class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true
      t.references :friend, index: true

      t.timestamps
    end
  end
end
