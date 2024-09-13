class RoomMailer < ApplicationMailer

  def created_reservation_user(reservation, user)
    @room = room
    @user = user
    mail(to: @user.email, subject: 'Resevation #{reservation.id} was created')
  end

  def created_reservation_admins(reservation, user)
    @reservation = reservation
    @user = user
    mail(to: @user.email, subject: 'Room was created')
  end

end