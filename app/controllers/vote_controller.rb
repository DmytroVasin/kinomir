class VoteController < ApplicationController

  load_and_authorize_resource

  def update
    @post = Post.find(params[:post_id])
    vote = @post.vote
       
    vote.score += 1 if params[:vote][:score] == "1"
    vote.score += 2 if params[:vote][:score] == "2"
    vote.score += 3 if params[:vote][:score] == "3"
    vote.score += 4 if params[:vote][:score] == "4"
    vote.score += 5 if params[:vote][:score] == "5"

    vote.count_users += 1

    vote.users << current_user
    
      respond_to do |format|
        if vote.save
          format.html { 
            redirect_to post_path(@post),
            :notice => "You vote counted!"
          }
          format.js
          # flash[:notice] = "You vote counted!"
          # redirect_to post_path(post)
        end
      end
  end
   

  def clear
    post = Post.find(params[:post_id])
    post.vote.update_attributes(:score => 0)
     
    flash[:notice] = "Clear!"
    redirect_to post_path(post)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You have already voted"
    redirect_to post_path(Post.find(params[:post_id]))
  end
end