class LettersController < ApplicationController
  def index
    @letters = Letter.all
  end
  def new
    @letter = Letter.new
    @typeLetter = TypeLetter.all
    @cbMail = CbMail.all
    @letter.date_letter = Time.now
  end
  def edit
    @letter = Letter.find(params[:id])
    @typeLetter = TypeLetter.all
    @cbMail = CbMail.all
  end
  def update
    letter = Letter.find(params[:id])
    if letter.update(letter_params)
      redirect_to letters_path
    else
      @letter = Letter.find(params[:id])
      render "edit"
    end
  end
  def create
    letter = Letter.new(letter_params)
    if letter.save
      redirect_to letters_path
    else
      @letter = Letter.find(params[:id])
      render "new"
    end
  end
  private
  def letter_params
    params.require(:letter).permit( :type_letter_id, :cb_mail_id, :letter_id, :date_letter, :number1, :number2,
                                    :summary, :after_mail, :required_answer, :state )
  end
end
