class Api::ContactsController < ApplicationController
  def index
    render json: Contact.all, array_serializer: ContactSerializer
  end

  def show
    render json: Contact.find(params[:id])
  end
end
