class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.boolean     :email_enabled
      t.integer     :type_recipient   # 1. Рассылка уведомления о вх из ЦБ, 7. Рассылка о неуходе почты в ЦБ
      t.string      :email
      t.string      :name

      t.timestamps null: false
    end
  end
end
