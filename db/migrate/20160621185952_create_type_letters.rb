class CreateTypeLetters < ActiveRecord::Migration
  def change
    create_table :type_letters do |t|
      # 1 - обычное письмо, 2 - приказ, 9 - перечень приказов, 51 - курсы, 52  - ответ на письмо ЦБ, 53 - письмо в ЦБ
      t.string  :direction  # 1 - вх, 2 - исх
      t.float   :service_number # пример: 1
      t.string  :name           # пример: обычное письмо

      t.timestamps null: false
    end
  end
end
