module ApplicationHelper
  def badge_class_for(status)
    case status
    when 'booked'
      'bg-primary'
    when 'checked_in'
      'bg-success'
    when 'checked_out'
      'bg-warning'
    when 'no_show'
      'bg-secondary'
    when 'cancelled'
      'bg-danger'
    else
      'bg-light'
    end
  end

end

