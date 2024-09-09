module RoomsHelper
  def room_available?(room, check_in_date, check_out_date)
    # Convert the dates to Date objects, handling any nil cases
    check_in = check_in_date || Date.today
    check_out = check_out_date || Date.tomorrow

    # Check if any reservations overlap with the requested check-in and check-out dates
    overlapping_reservations = room.reservations.where(
      "(check_in_date <= ? AND check_out_date >= ?) OR (check_in_date >= ? AND check_in_date < ?)",
      check_out, check_in, check_in, check_out
    )

    # If there are no overlapping reservations, the room is available
    overlapping_reservations.none?
  end
end
