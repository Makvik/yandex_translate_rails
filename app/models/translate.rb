class Translate < ActiveRecord::Base
  validates :text, presence: true
  validates :translated_text, presence: true
  validates :lang_short, presence: true
  validates :lang_long, presence: true
end
