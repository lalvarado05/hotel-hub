class RoomMailer < ApplicationMailer
  def created_room(room, user)
    @room = room
    @user = user
    mail(to: @user.email, subject: 'Room was created')
  end
end