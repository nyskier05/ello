class UsersController < ApplicationController

	def approve_user
	  user = User.find(params[:id])
	  user.approved = true
	  if user.save
	    flash[:notice] = "#{user.first_name} #{user.last_name}, #{user.email}, approved"
	  else
	    flash[:alert] = "#{user.first_name} #{user.last_name}, #{user.email}, approval failure"
	  end
	  redirect_to :back
	end

end