class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ID письма в ЦБ: уведомление
  @@ml_notice_id = 6
  # ID письма в ЦБ: ответ
  @@ml_answer_id = 7

end
