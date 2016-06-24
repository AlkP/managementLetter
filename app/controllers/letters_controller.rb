class LettersController < ApplicationController
  def index
    @letters = Letter.all
    @attacheds = Attached.all
  end
  def new
    @letter = Letter.new
    if params[:format] == '1'
      @typeLetters = TypeLetter.where('direction = ?', 1)
    elsif params[:format] == '2'
      @typeLetters = TypeLetter.where('direction = ?', 2)
    else
      @typeLetters = TypeLetter.where('direction = ?', 2)
      @letter.letter_id = params[:format]
      @letter.type_letter_id = 6
    end
    @cbMail = CbMail.all
    @letter.date_letter = Time.now
  end
  def create
    letter = Letter.new(letter_params)
    if letter.save
      redirect_to edit_letter_url(letter)
    else
      @letter = Letter.find(params[:id])
      render "new"
    end
  end
  def edit
    @letter = Letter.find(params[:id])
    # @direction = @letter.type_letter.direction.to_s
    @parent = Letter.find_by_letter_id(@letter.id)
    @answer = @parent.nil?
    if @letter.type_letter.direction == 2 or @letter.required_answer == 1
      @answer = false
    end
    @typeLetters = TypeLetter.where('direction = ?', @letter.type_letter.direction)
    @cbMail = CbMail.all
    @attacheds = Attached.where('letter_id = ?',params[:id])
  end
  def update
    letter = Letter.find(params[:id])
    if letter.update(letter_params)
      redirect_to edit_letter_url(letter)
    else
      @letter = Letter.find(params[:id])
      render "edit"
    end
  end
  def show
    letter = Letter.find(params[:id])
    attacheds = Attached.where('letter_id = ?', letter.id)
    attacheds.each do |f|
      FileUtils.copy f.attached.path, f.letter.cb_mail.path_to_out
    end
    letter.state = 88
    # letter.save
    redirect_to edit_letter_url(letter)
  end
  def destroy
    letter = Letter.find(params[:id])
    letter.destroy
    redirect_to letters_path
  end
  private
  def letter_params
    params.require(:letter).permit( :type_letter_id, :cb_mail_id, :letter_id, :date_letter, :number1, :number2,
                                    :summary, :after_mail, :required_answer, :state )
  end
end
