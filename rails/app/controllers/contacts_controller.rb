class ContactsController < ApplicationController

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      flash[:notice] = "Yah! We've added #{@contact.name}."
      redirect_to root_path
    else
      render "dashboards/show"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :frequency)
  end

end
