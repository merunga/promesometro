class HomeController < ApplicationController
  
  def show
    @declarations = Declaration.limit(5).order('id DESC')
    @comments = []#Declaration.citizens_approved.limit(5).order('id DESC')
  end

end
