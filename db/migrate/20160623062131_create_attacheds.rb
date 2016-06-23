class CreateAttacheds < ActiveRecord::Migration
  def change
    create_table :attacheds do |t|
      t.string      :name
      t.attachment  :attached

      t.references  :letter, index: true

      t.timestamps null: false
    end
  end
end
