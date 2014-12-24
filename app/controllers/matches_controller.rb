class MatchesController < ApplicationController
  def index
    @matches = Match.all.where("inviter_id = #{current_user.id} OR invitee_id = #{current_user.id}")
  end

  def show
    current_user.notifications_unread.where(notifiable_id: params[:id]).update_all(notified: true)
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
    @match.invitee = User.find(params["user"])
    @match.build_address
    if logged_in? && current_user.address != nil
      @match.address = current_user.address
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def create
    @match = Match.new(match_params)
    @match.inviter = current_user
    if @match.save
      flash[:success] = "Challenge sent!"
      redirect_to @match.invitee
    else
      render 'new'
    end
  end

  def update
    @match = Match.find(params[:id])
    current_is_inviter = @match.inviter == current_user
    other_player = current_is_inviter ? @match.invitee : @match.inviter
    if current_is_inviter
      @match.inviter_accepted = true
      @match.invitee_accepted = nil
    else
      @match.inviter_accepted = nil
      @match.invitee_accepted = true
    end
    if @match.update_attributes(match_params)
      @match.edit_notification( other_player, current_user)
      flash[:success] = "Match updated"
      redirect_to @match
    else
      render 'edit'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def respond
    @match = Match.find(params[:id])
    response = params[:response]
    if @match.inviter == current_user
      @match.inviter_accepted = response
    elsif @match.invitee == current_user
      @match.invitee_accepted = response
    else
      redirect_to :back
    end

    if @match.save
      flash[:success] = "Response sent!"
      @match.response_notification( @match.inviter == current_user ? @match.invitee : @match.inviter, 
        current_user, response)
    else
      flash[:danger] = "Could not send response at this time."
    end
    redirect_to :back
  end

  def submit_message
    respond_to do |format|
      match = Match.find(params[:match_id])
      if (match.inviter == current_user || match.invitee == current_user) && !params[:content].blank?
        @message = Message.create(sender: current_user, message: params[:content], messagable: match)
        Notification.create!(receiver:              match.inviter == current_user ? match.invitee : match.inviter,
                             sender:                current_user,
                             notification_type_id:  4,
                             notifiable:            match)
        format.js
      end
    end
  end

  private
    def match_params
      params.require(:match).permit(:invitee_id, :date, :time,
        address_attributes: [:address_1, :address_2, :city, :state, :postal_code, :country])
    end
end
