class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start_day, null: false
      t.date :end_day, null: false
      t.integer :number_of_people, null: false
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
