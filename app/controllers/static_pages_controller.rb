class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end
  
  def get_notifications
    respond_to do |format|               
      format.js
    end
  end
end
