class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :comment
      t.boolean :display, default: true

      t.timestamps
    end
  end
end
