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
      flash[:success] = 'Ящик успешно отредактирован.'
      redirect_to cb_mails_path
    else
      flash[:error] = 'Ящик редактировать невозможно'
      @cbMail = CbMail.find(params[:id])
      render "edit"
    end
  end
  def create
    cbMail = CbMail.new(cb_mail_params)
    if cbMail.save
      flash[:error] = 'Ящик успешно создан.'
      redirect_to cb_mails_path
    else
      flash[:error] = 'Ящик неудалось создать.'
      @cbMail = CbMail.find(params[:id])
      render "new"
    end
  end
  def destroy
    cbMail = CbMail.find(params[:id])
    begin
      cbMail.destroy
    rescue
      flash[:error] = 'Ящик удалить невозможно'
    else
      flash[:success] = 'Ящик успешно удален.'
    end
    redirect_to cb_mails_path
  end
  private
  def cb_mail_params
    params.require(:cb_mail).permit( :email, :path_to_out, :description )
  end
end
