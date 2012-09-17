class ApplicationController < ActionController::Base
  protect_from_forgery

  	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


	private
    	def record_not_found
  		  flash[:alert] = "page not found"
  		  redirect_to root_path
  		end
end