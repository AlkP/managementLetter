class LetterMailer < ApplicationMailer
  default reply_to: "robot@genbank.biz"
  default from: "robot@genbank.biz"

  def incoming_letter(attacheds = nil, url = nil, email = nil)
    email.nil? ? @email = 'a.pasenko@crimea.genbank.ru' : @email = email
    url.nil? ? @url  = 'http://gb.genbank.ru' : @url = url
    unless attacheds.nil?
      attacheds.each do |f|
        attachments[f.attached.original_filename] = File.read(f.attached.path)
      end
    end
    mail(to: @email, subject: 'ЦБ')
  end

end
