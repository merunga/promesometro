class ComentarioController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @promise = Promise.find(params[:milestone_id])
    @comment = Comentario.build_from(@promise, params[:comment][:ciudadano_id], params[:comment][:body])
    @comment.save!
    flash[:notice]= 'El comentario ha sido creado con exito'
  rescue ActiveRecord::RecordInvalid => ex
    if @comment
      errors = @comment.errors.full_messages.to_sentence
    else
      errors = ex
    end
    flash[:error] = errors
  ensure
    redirect_to promesa_url(@promise.slug)
  end
end
