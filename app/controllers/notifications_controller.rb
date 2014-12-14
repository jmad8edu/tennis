class NotificationsController < ApplicationController
  def mark_read
    respond_to do |format|
      Notification.where(receiver: current_user).update_all(notified: true)
      format.js
    end
  end

  def index
    respond_to do |format|
      format.html do
        @notifications = current_user.notifications_received.order(created_at: :desc)
      end
      format.js do
        limit = params[:limit] != nil ? params[:limit].to_i : 10
        offset = params[:offset] != nil ? params[:offset].to_i : 0
        @notifications = current_user.notifications_received.limit(limit + 1).offset(offset).order(created_at: :desc)
        if @notifications.size == limit + 1
          @more = true
          @notifications = @notifications.take limit
        else
          @more = false
        end
      end
    end
  end
end
