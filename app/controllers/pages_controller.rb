class PagesController < ApplicationController
  def home
  	@user = User.all.paginate(:page => params[:page], :per_page => 25)
  end

  def about
  end

end
