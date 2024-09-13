class AddReservationToReviews < ActiveRecord::Migration[7.2]
  def change
    add_reference :reviews, :reservation, null: false, foreign_key: true
  end
end
