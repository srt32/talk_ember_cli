class ConversationsController < ApplicationController

  def create
    contact = current_user.contacts.find(params[:contact_id])
    conversation = contact.conversations.new
    if conversation.save
      flash[:notice] = "We got it!"
    else
      flash[:error] = "Whoops, something went wrong"
    end

    redirect_to root_path
  end

end
