class CategoriesController < ApplicationController
	before_filter :check_admin_area_enter!

	def index
		@categories = Category.all
	end
	def new 	
		@category = Category.new
	end
	def create
		@category = Category.new(params[:category])

		if @category.save
			redirect_to :action => :index
		else 
			render 'new'
		end	
	end
	def destroy
		@category = Category.find(params[:id])
  		@category.destroy
  		redirect_to :action => :index
	end
	def check_admin_area_enter!
		if (current_user && current_user.roles.first.name == "admin")
			
		else
			redirect_to root_path, :alert => "You don't have access to this page"
		end
	end

end
