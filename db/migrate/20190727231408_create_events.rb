class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :organizer, index: true

      t.string :title
      t.string :details
      t.string :category

      t.string :address
      t.string :city
      t.string :state

      t.datetime :date

      t.timestamps
    end
  end
end
