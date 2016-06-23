class AttachedsController < ApplicationController
  def new
    @attached = Attached.new
    @attached.letter_id = params[:format]
  end
  def create
    attached = Attached.create(attached_params)
    attached.save
    redirect_to edit_letter_url(params[:attached][:letter_id])
  end
  def destroy
    attached = Attached.find(params[:id])
    letter_id = attached.letter_id
    attached.destroy
    redirect_to edit_letter_url(letter_id)
  end
  private
  def attached_params
    params.require(:attached).permit(:letter_id, :attached)
  end
end
