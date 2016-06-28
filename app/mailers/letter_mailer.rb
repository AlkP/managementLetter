class LetterMailer < ApplicationMailer
  default reply_to: "robot@genbank.biz"
  default from: "robot@genbank.biz"

  def incoming_letter(email = nil)
    email.nil? ? @email = 'apasenko@gmail.com' : @email = email
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'ЦБ')
  end

end
