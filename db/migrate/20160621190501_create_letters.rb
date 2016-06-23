class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.references  :type_letter, index: true
      t.references  :cb_mail, index: true # ящик для ответа / ящик для исх
      t.references  :letter, index: true # "родитель" сообщения, для ответа - id письма из ЦБ

      t.date    :date_letter
      t.string  :number1        # исх номер 1 часть, например: Т35-36-12
      t.string  :number2        # исх номер 2 часть, например: 2218
      t.string  :summary        # краткое содержание
      t.integer :after_mail     # 1 - досылка почты не будет, 2 - будет выслан бумажный вариант
      t.integer :required_answer
      # 1 - ответ не требуется, 2 - требуется ответ в электронном виде, 3 - требуется ответ за подписью руководителя
      t.integer :state          # 88 - письмо отправлено, 99 - заблокировать письмо на изменение

      t.timestamps null: false
    end
  end
end
