class ReservationMailer < ApplicationMailer

  def created_reservation_user(reservation, user)
    @reservation = reservation
    @user = user
    @reservation_code = reservation.confirmation_code
    mail(to: @user.email, subject: "Reservation #{@reservation.id} was created")
  end

  def created_reservation_admins(reservation, user)
    @reservation = reservation
    @user = user
    mail(to: 'alvaradoarias05@gmail.com', subject: 'A new reservation was created')
  end

end

