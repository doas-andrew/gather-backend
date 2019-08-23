class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :login_name
      t.string :password
      
    	t.string :first_name
    	t.string :last_name
    	t.string :full_name

      t.string :avatar_url
    	t.string :friend_settings

      t.timestamps
    end
  end
end
