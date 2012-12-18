class VotesController < ApplicationController
  load_and_authorize_resource
  
  def vote_up
    vote_action {
      #@votable.vote_up current_ciudadano
      @votable.liked_by current_ciudadano
    }
  end
  
  def vote_down
    vote_action {
      #@votable.vote_down current_ciudadano
      @votable.downvote_from current_ciudadano
    }
  end
  
private
  def vote_action(&block)
    @type = params[:type]
    @votable = @type.capitalize.constantize.find(params[:key])
    
    block.call
    
    respond_to do |format|
        format.html { render 'social/_votar', :layout => !request.xhr? }
    end
  end
end
