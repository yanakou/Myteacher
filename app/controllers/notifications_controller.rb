class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(%i[visitor tweet room visited])
                                 .page(params[:page]).per(20).where.not(visitor_id: current_user.id)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # @activities = current_user.active_notifications.includes(%i[visitor tweet room visited]).page(params[:page]).per(20)
  end
end
