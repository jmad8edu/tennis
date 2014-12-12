class UsersController < ApplicationController
  	before_action :logged_in_user, only: [:index, :edit, :update]
  	before_action :correct_user,   only: [:edit, :update]
  	helper_method :sort_param, :direction_param

	def index
    	@users = User.paginate(page: params[:page]).order(sort_param + " " + direction_param)
  	end

	def new
		@user = User.new
		@skill_levels = SkillLevel.all
		@user.build_address
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

  	def edit
    	@user = User.find(params[:id])
		@skill_levels = SkillLevel.all
  	end

  	def update
    	@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			@skill_levels = SkillLevel.all
			render 'edit'
		end
  	end

	private

		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, 
				:password_confirmation, :phone, :skill_level_id, :right_left_handed, 
				address_attributes: [:address_1, :address_2, :city, :state, :postal_code, :country])
		end

	    def logged_in_user
	      unless logged_in?
        	store_location
	        flash[:danger] = "Please log in."
	        redirect_to login_url
	      end
	    end

	    def correct_user
	      @user = User.find(params[:id])
      	  redirect_to(root_url) unless current_user?(@user)
	    end

	    def sort_param
			%w[first_name last_name skill_level_id].include?(params[:sort]) ? params[:sort] : "first_name"
	    end

	    def direction_param
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	    end
end
