class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    Notification.where(arg_id: params[:id], notified: false).each do |n|
      n.notified = true
      n.save
    end
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
    # date = params["datetime"]["date"]
    # time = params["datetime"]["time"]
    # params[:scheduled_date] = "#{date} #{time}".strip
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
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
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
    else
      flash[:danger] = "Could not send response at this time."
    end
    redirect_to :back
  end

  private
    def match_params
      params.require(:match).permit(:invitee_id, :date, :time,
        address_attributes: [:address_1, :address_2, :city, :state, :postal_code, :country])
    end
end
