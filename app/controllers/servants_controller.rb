class ServantsController < ApplicationController
	before_filter :authenticate_admin!, :except => [:show]

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
end
