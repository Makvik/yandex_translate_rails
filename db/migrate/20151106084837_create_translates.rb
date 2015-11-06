class CreateTranslates < ActiveRecord::Migration
  def change
    create_table :translates do |t|
      t.text :text
      t.text :translated_text
      t.string :lang_short
      t.string :lang_long
      t.time :time

      t.timestamps null: false
    end
  end
end
