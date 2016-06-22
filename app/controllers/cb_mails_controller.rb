class CbMailsController < ApplicationController
  def index
    @cbMails = CbMail.all
  end
  def new
    @cbMail = CbMail.new
  end
  def edit
    @cbMail = CbMail.find(params[:id])
  end
  def update
    cbMail = CbMail.find(params[:id])
    if cbMail.update(cb_mail_params)
      redirect_to cb_mails_path
    else
      @cbMail = CbMail.find(params[:id])
      render "edit"
    end
  end
  def create
    cbMail = CbMail.new(cb_mail_params)
    if cbMail.save
      redirect_to cb_mails_path
    else
      @cbMail = CbMail.find(params[:id])
      render "new"
    end
  end
  private
  def cb_mail_params
    params.require(:cb_mail).permit( :email, :path_to_out, :description )
  end
end
