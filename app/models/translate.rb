class Translate < ActiveRecord::Base
  validates :text, presence: true, length: { minimum: 1 }
  validates :translated_text, presence: true, length: { minimum: 1 }
  validates :lang_short, presence: true
  validates :lang_long, presence: true
end
