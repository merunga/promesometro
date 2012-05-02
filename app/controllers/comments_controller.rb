class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def reply
    @reply = Comment.build_from(@comment.commentable, current_ciudadano.id, params[:comment][:body])
    @reply.save!
    @reply.move_to_child_of(@comment)
    level = 1#params[:level]==0?1:params[:level]
    position = @comment.children.count
    
    respond_to do |format|
      format.html { render '_reply', :layout => !request.xhr?,
        :locals => {:level => level, :position => position} }
    end
  end
end
