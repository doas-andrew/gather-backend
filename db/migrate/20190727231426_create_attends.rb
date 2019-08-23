class CreateAttends < ActiveRecord::Migration[5.2]
  def change
    create_table :attends do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
