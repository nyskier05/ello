class UsersController < ApplicationController

	def approve_user
	  user = User.find(params[:id])
	  user.approved = true
	  if user.save
	    flash[:notice] = "[#{user.first_name} #{user.last_name} | #{user.email}] --> has been approved"
	    AdminMailer.new_user_approved(user).deliver
	  else
	    flash[:alert] = "[#{user.first_name} #{user.last_name} | #{user.email}] --> approval failure"
	  end
	  redirect_to :back
	end

	def unapprove_user
	  user = User.find(params[:id])
	  user.approved = false
	  if user.save
	    flash[:notice] = "[#{user.first_name} #{user.last_name} | #{user.email}] --> unapproval successful (approval removed)"
	  else
	    flash[:alert] = "[#{user.first_name} #{user.last_name} | #{user.email}] --> unapproval failure"
	  end
	  redirect_to :back
	end
end