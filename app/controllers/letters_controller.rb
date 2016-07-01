class LettersController < ApplicationController
  def index
    @letters = Letter.all.order('date_letter DESC')
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
    @letter = Letter.find(params[:id])

    @parent = Letter.find_by_letter_id(@letter.id)
    @typeLetters = TypeLetter.where('direction = ?', @letter.type_letter.direction)
    @cbMail = CbMail.all
    @attacheds = Attached.where('letter_id = ?',params[:id])
  end
  def sending
    letter = Letter.find(params[:id])
    attacheds = Attached.where('letter_id = ?', params[:id])
    error = false
    if letter.type_letter.direction == 1
      recipients = Recipient.where('type_recipient = ? and email_enabled = ?', 1, "t")
      recipients.each do |f|
        # LetterMailer.incoming_letter(attacheds, '//10.3.222.61:3000'+letter_path, f.email).deliver_now
        LetterMailer.incoming_letter(attacheds, request.base_url+letter_path, f.email).deliver_now
      end
      error = true
    else
      attacheds.each do |f|
        FileUtils.copy f.attached.path, f.letter.letter.cb_mail.path_to_out
      end
      error = true
    end
    # Нужно доделать при отправке и копировании на ошибки
    unless error
      letter.state = 88
      letter.save
    end
    redirect_to edit_letter_url(letter)
  end
  def destroy
    letter = Letter.find(params[:id])
    attached = Attached.where('letter_id = ?', params[:id])
    letter.destroy
    attached.destroy_all
    redirect_to letters_path
  end
  private
  def letter_params
    params.require(:letter).permit( :type_letter_id, :cb_mail_id, :letter_id, :date_letter, :number1, :number2,
                                    :summary, :after_mail, :required_answer, :state )
  end
end
