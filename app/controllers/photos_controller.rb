class PhotosController < ApplicationController

  before_filter :the_post
  before_filter :authenticate_user!
  
  def index
    
    @photos = Photo.where("post_id = ?", @post)

      if ( current_user.id == @curren.user_id  or current_user.roles.first.name == "admin" )
          respond_to do |format|
            format.html # index.html.erb
          end
      else 
          flash[:alert] = 'You are not allowed for this page'
          redirect_to post_path(@post.id)
      end
  end


  def show
    @photo = Photo.find(params[:id])

      if ( current_user.id == @curren.user_id  or current_user.roles.first.name == "admin"  )
        respond_to do |format|
          format.html # show.html.erb
        end
      else
        flash[:alert] = 'You are not allowed for this page'
        redirect_to post_path(@post.id)
      end  
  end


  def new
    @photo = Photo.new
      if ( current_user.id == @curren.user_id  or current_user.roles.first.name == "admin"  )
        respond_to do |format|
          format.html # new.html.erb
        end
      else
        flash[:alert] = 'You are not allowed for this page'
        redirect_to post_path(@post.id)
      end 
  end


  def create
    @photo = @post.photos.new(params[:photo])
    if @photo.save
      flash[:notice] = 'Photo is add'
      redirect_to new_post_photo_path
    else
      flash[:alert] = 'This format of data is not supported'
      redirect_to post_photos_path
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to post_photos_path(@post) }
      format.json { head :no_content }
    end
  end
end


private 

    def the_post
      @post = Post.find(params["post_id"])
      @curren = Post.find(@post)
    end