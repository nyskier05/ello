class PagesController < ApplicationController
  def home
  	@user = User.where(approved: true).paginate(:page => params[:page], :per_page => 25)
  end

  def church
  	@user = User.find(params[:church]).where(approved: true).paginate(:page => params[:page], :per_page => 25)
  end

  def about
  end

end
