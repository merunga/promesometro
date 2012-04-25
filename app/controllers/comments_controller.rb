class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def vote_up
    vote_action {
      @comment.vote_up current_ciudadano
    }
  end
  
  def vote_down
    vote_action {
      @comment.vote_down current_ciudadano
    }
  end
  
private
  def vote_action(&block)
    @comment = Comment.find(params[:id])
    
    block.call
    
    respond_to do |format|
        format.html { render '_votar', :layout => !request.xhr?, :comment => @comment }
    end
  end
end
