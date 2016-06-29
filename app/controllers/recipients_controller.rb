class RecipientsController < ApplicationController
  def index
    @recipients = Recipient.all
  end
  def new
    @recipient = Recipient.new
  end
  def edit
    @recipient = Recipient.find(params[:id])
  end
  def update
    recipient = Recipient.find(params[:id])
    if recipient.update(recipient_params)
      redirect_to recipients_path
    else
      @recipient = Recipient.find(params[:id])
      render "edit"
    end
  end
  def create
    recipient = Recipient.new(recipient_params)
    if recipient.save
      redirect_to recipients_path
    else
      @recipient = Recipient.new
      render "new"
    end
  end
  def destroy
    recipient = Recipient.find(params[:id])
    recipient.destroy
    redirect_to recipients_path
  end
  private
  def recipient_params
    params.require(:recipient).permit( :email_enabled, :type_recipient, :name, :email )
  end
end
