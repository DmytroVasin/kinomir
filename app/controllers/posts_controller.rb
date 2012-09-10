class PostsController < ApplicationController
	before_filter :check_guest_logged_in!, :except => [:show, :index]
	def index
		@posts = Post.order('created_at DESC')
	end
	def new
		@post = Post.new
	end
	def create
  		@post = Post.new(params[:post])
  		@post.user = current_user
  		if admin_signed_in?
  			@post.admin = current_admin
  		end

  		if @post.save
  		  redirect_to post_path(@post.id)
  		else
  		  render 'new'
  		end
	end
	def show
		@post = Post.find(params[:id])
	end
	def edit
		@post = Post.find(params[:id])
	end
	def update
  		@post = Post.find(params[:id])
  		if @post.update_attributes(params[:post])
  		  redirect_to post_path(@post.id)
  		else
  		  render 'edit'
  		end
	end
	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy
	  redirect_to posts_path
	end
	
	private
	
	def check_guest_logged_in! 
	  if user_signed_in?
	  	authenticate_user!
	  elsif admin_signed_in?
	    authenticate_admin!
	  else
	  	redirect_to root_path
	  end   
	end
end
