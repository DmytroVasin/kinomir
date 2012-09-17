class PostsController < ApplicationController
	
	load_and_authorize_resource

	before_filter :set_timezone 
	
	def set_timezone  
	 min = request.cookies['time_zone'].to_i
	 Time.zone = ActiveSupport::TimeZone[min]
	end 


	def index
		@posts = Post.order('created_at DESC').text_search(params[:query]).page(params[:page]).per(6)
		
		@posts = @posts.by_category_id(params[:cat]).page(params[:page]).per(6) if params[:cat].present?
	end
	def new
		
	end
	def create
  		
  		@post.user = current_user

  		if @post.save
  		  flash[:notice] = "Post created!"
  		  redirect_to post_path(@post.id)
  		else
  		  render 'new'
  		end
	end
	def show
		
	end
	def edit
		
	end
	def update
  		
  		if @post.update_attributes(params[:post])
  		  flash[:notice] = "Post updated"
  		  redirect_to post_path(@post.id)
  		else
  		  render 'edit'
  		end
	end
	def destroy
	  
	  @post.destroy
	  redirect_to posts_path
	end
	
end
