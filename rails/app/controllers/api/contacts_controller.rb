class Api::ContactsController < ApiController
  respond_to :json

  def create
    contact = current_user.contacts.create(contact_params)

    respond_with contact, location: false
  end

  def index
    render json: Contact.includes(:conversations).all, array_serializer: ContactSerializer
  end

  def show
    render json: current_user.contacts.find(params[:id])
  end

  private

  def contact_params
    params.require(:contact).permit(:frequency, :name)
  end
end
