class ServantsController < ApplicationController
	before_filter :check_admin_area_enter!, :except => [ :show ]

	def index
		@servants = User.order('created_at ASC')
	end
	def show
		@servant = User.find(params[:id])
		@postsofservant = @servant.posts
	end
	def destroy
		@servant = User.find(params[:id])
		@servant.destroy
		redirect_to servants_path
	end
	
	private

	def check_admin_area_enter!
		if (current_user && current_user.roles.first.name == "admin")
		else
			redirect_to root_path, :alert => "You don't have access to this page"
		end
	end




end
