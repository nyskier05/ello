class PagesController < ApplicationController
  def home
  	@user = User.all
  end

  def about
  end
  
end
