class CreateCbMails < ActiveRecord::Migration
  def change
    create_table :cb_mails do |t|
      # ящики электроной почты ЦБ
      t.string  :email
      t.string  :path_to_out
      t.string  :description

      t.timestamps null: false
    end
  end
end
