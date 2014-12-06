class UsersController < ApplicationController
	def new
		@user = User.new
		@skill_levels = SkillLevel.all
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
	    flash[:success] = "Welcome to the Sample App!"
	    log_in @user
	    redirect_to @user
	  else
		@skill_levels = SkillLevel.all
	    render 'new'
	  end
	end

	def show
    	@user = User.find(params[:id])
  	end

	private

		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
				:phone, :court_address, :skill_level_id, :right_left_handed)
		end
end
