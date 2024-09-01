class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.decimal :price
      t.boolean :available

      t.timestamps
    end
  end
end
