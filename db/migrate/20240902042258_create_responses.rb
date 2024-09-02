class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
