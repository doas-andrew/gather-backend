class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :sender, index: true
      t.references :recipient, index: true

      t.string :subject
      t.string :content
      t.boolean :seen, default: true

      t.boolean :original_msg, default: true

      t.timestamps
    end
  end
end
