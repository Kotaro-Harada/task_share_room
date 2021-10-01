class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :place, null: false
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
