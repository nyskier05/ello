class ConversationsController < ApplicationController
	before_action :authenticate_user!

def index
	@users = User.all
	@conversations = Conversation.involving(current_user)
	#unless session[:user_id] == @conversations.sender_id OR session[:user_id] == @conversations.recipient_id 
  #    flash[:notice] = "You don't have access to that!"
  #    return
  #end
end

def create
	if Conversation.between(params[:sender_id],params[:recipient_id]).present?
    @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
else
  @conversation = Conversation.create!(conversation_params)
end
 redirect_to conversation_messages_path(@conversation)

end

private
	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end
end