class NotificationsController < ApplicationController
  def index
    respond_to do |format|
      limit = params[:limit] != nil ? params[:limit].to_i : 10
      offset = params[:offset] != nil ? params[:offset].to_i : 0
      @notes = current_user.notifications_received.limit(limit + 1).offset(offset).order(created_at: :desc)
      if @notes.size == limit + 1
        @more = true
        @notes = @notes.take limit
      else
        @more = false
      end
      format.html
      format.js
    end
  end
end
