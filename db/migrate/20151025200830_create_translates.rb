class CreateTranslates < ActiveRecord::Migration
  def change
    create_table :translates do |t|
      t.text :text
      t.string :translation_direction
      t.text :translated_text

      t.timestamps null: false
    end
  end
end
