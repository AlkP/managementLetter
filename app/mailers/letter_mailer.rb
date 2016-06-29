class LetterMailer < ApplicationMailer
  default reply_to: "robot@genbank.biz"
  default from: "robot@genbank.biz"

  def incoming_letter(url = nil, name = nil, email = nil)
    email.nil? ? @email = 'a.pasenko@crimea.genbank.ru' : @email = email
    name.nil? ? @email = %("Пасенко Алексей Владимирович" <#{@email}>) : @email = %("#{name}" <#{@email}>)
    unless name.nil?
      @email = %("#{name}" <#{@email}>)
    end
    url.nil? ? @url  = 'http://gb.genbank.ru' : @url = url
    mail(to: @email, subject: 'ЦБ')
  end

end
