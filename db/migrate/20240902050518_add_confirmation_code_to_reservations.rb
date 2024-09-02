class AddConfirmationCodeToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :confirmation_code, :string
  end
end
