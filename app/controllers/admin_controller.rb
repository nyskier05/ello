class AdminController < ApplicationController

	def index
    if params[:approved] == "false"
      @user = User.where(approved: false)
    else
      @user = User.all
    end
  end

end