class LettersController < ApplicationController
  def index
    @letters = Letter.all.includes(:letter).includes(letter: [:cb_mail]).includes(:type_letter).includes(:cb_mail).order('date_letter DESC').order('number2 DESC')
  end
  def new_old
    @letter = Letter.new
    if params[:format] == '1'
      @typeLetters = TypeLetter.where('direction = ?', 1)
    elsif params[:format] == '2'
      @typeLetters = TypeLetter.where('direction = ?', 2)
    else
      @typeLetters = TypeLetter.where('direction = ?', 2)
      @letter.letter_id = params[:format]
      @letter.type_letter_id = 6
      doc = DocxReplace::Doc.new("#{Rails.root}/lib/docx/template.docx", "#{Rails.root}/tmp")
      doc.replace(/number_one/, "123qqqwe")
      tmp_file = Tempfile.new('word_template.docx', "#{Rails.root}/tmp")
      doc.commit(tmp_file.path)
      send_file tmp_file.path
    end
    @cbMail = CbMail.all
    @letter.date_letter = Time.now
  end
  def new
    @letter = Letter.new
    @typeLetters = TypeLetter.where('direction = ?', 1)
    @cbMail = CbMail.all
    @letter.date_letter = Time.now
  end
  def new_out
    @letter = Letter.new
    @typeLetters = TypeLetter.where('direction = ?', 2)
    @cbMail = CbMail.all
    @letter.date_letter = Time.now
  end
  def new_response
    @letter = Letter.new
    @letter.date_letter = Time.now
    @letter.letter_id = params[:id]
    letter_in = Letter.find(params[:id])
    @letter_in__required_answer = letter_in.required_answer
    @letter.type_letter_id = (letter_in.required_answer == 4 ) ? @@ml_answer_id : @@ml_notice_id
    @letter.summary = "Ответ на письмо ЦБ от " + letter_in.date_letter.to_s + " №" + letter_in.number1 + "/" + letter_in.number2
    if letter_in.required_answer == 2
      if @letter.save
        path= "tmp/answer.txt"
        File.open(path, "w+") do |f|
          f.write("Письмо №"+@letter.letter.number1+"/"+@letter.letter.number2+" от "+@letter.date_letter.to_s+"\r")
          f.write("Получено АО ""ГЕНБАНК""\r")
          f.write("-----\r")
          f.write("-----\r")
          f.write("исп. Пасенко А.В., телефон 550810\r")
        end
        att = Attached.new
        att.letter_id = @letter.id
        att.attached = File.open(path)
        att.save
        redirect_to edit_letter_path(@letter)
      end
    end
    @typeLetters = TypeLetter.where('direction = ?', 2)
    @cbMail = CbMail.all
  end
  def create
    letter = Letter.new(letter_params)
    if letter.save
      flash[:ok] = "Созданно новое письмо"
      redirect_to edit_letter_url(letter)
    else
      flash[:error] = letter.errors.full_messages
      redirect_to new_letter_path(params[:letter][:letter_id])
    end
  end
  def edit
    @letter = Letter.find(params[:id])
    @child = Letter.find_by_letter_id(@letter.id)
    @answer = @child.nil?
    if @letter.type_letter.direction == 2 or @letter.required_answer == 1
      @answer = false
    end
    @typeLetters = TypeLetter.where('direction = ?', @letter.type_letter.direction)
    @cbMail = CbMail.all
    @attacheds = Attached.where('letter_id = ?',params[:id])
  end
  def update
    @letter = Letter.find(params[:id])
    if @letter.update(letter_params)
      flash[:success] = "Письмо обновленно"
      redirect_to edit_letter_url(@letter)
    else
      @letter.errors.full_messages
      @child = Letter.find_by_letter_id(@letter.id)
      @answer = @child.nil?
      if @letter.type_letter.direction == 2 or @letter.required_answer == 1
        @answer = false
      end
      @typeLetters = TypeLetter.where('direction = ?', @letter.type_letter.direction)
      @cbMail = CbMail.all
      @attacheds = Attached.where('letter_id = ?',params[:id])
      render "edit"
    end
  end
  def show
    @letter = Letter.find(params[:id])

    @child = Letter.find_by_letter_id(@letter.id)
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
    msg = (!letter.number1.nil? and !letter.number2.nil?) ? letter.number1+'/'+letter.number2 : ""
    dte = letter.date_letter
    begin
      letter.destroy
    rescue
      flash[:error] = 'Письмо с номером №'+msg+' от '+dte.to_s+' не может быть удалено. Возможно у него есть связанные письма.'
    else
      attached.destroy_all
      flash[:success] = 'Письмо с номером №'+msg+' от '+dte.to_s+', а также все вложения: удалены.'
    end
    redirect_to letters_path
  end
  private
  def letter_params
    params.require(:letter).permit( :type_letter_id, :cb_mail_id, :letter_id, :date_letter, :number1, :number2,
                                    :summary, :after_mail, :required_answer, :state )
  end
end
