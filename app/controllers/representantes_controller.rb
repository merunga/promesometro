class RepresentantesController < ApplicationController
  def show
    lugar = (params[:posicion] == 'alcalde')? Province.find_by_name(params[:lugar]) : State.find_by_name(params[:lugar])
    render :json => lugar.officials[0]
  end
end
