class CategoriesController < ApplicationController
	before_filter :authenticate_admin!
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

end
