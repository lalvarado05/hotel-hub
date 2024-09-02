class CreateRoomBeds < ActiveRecord::Migration[7.2]
  def change
    create_table :room_beds do |t|
      t.references :room, null: false, foreign_key: true
      t.references :bed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
