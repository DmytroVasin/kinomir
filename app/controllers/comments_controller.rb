class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    @comment.user = current_user
    @comment.admin = current_admin

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
        format.js 
      else
        format.html { redirect_to post_path(@post) }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to post_path(@post)
  end  
end