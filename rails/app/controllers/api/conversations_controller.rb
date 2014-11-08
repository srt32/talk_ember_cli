class Api::ConversationsController < ApiController
  respond_to :json

  def create
    conversation = contact.conversations.create

    respond_with conversation, location: false
  end

  private

  def contact
    current_user.contacts.find(conversation_params[:contact_id])
  end

  def conversation_params
    params[:conversation].delete(:created_at)
    params.require(:conversation).permit(:contact_id)
  end
end
