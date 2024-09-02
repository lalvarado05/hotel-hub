class CreateRoomServices < ActiveRecord::Migration[7.2]
  def change
    create_table :room_services do |t|
      t.references :room, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
