class PagesController < ApplicationController
  def home
  	@user = User.where(approved: true).paginate(:page => params[:page], :per_page => 25)
  end

  def about
  end

	def church
  	@user = User.where(church: params[:church]).where(approved: true).paginate(:page => params[:page], :per_page => 25)
  end

	def neighborhood
  	@user = User.where(neighborhood: params[:neighborhood]).where(approved: true).paginate(:page => params[:page], :per_page => 25)
  end
end
