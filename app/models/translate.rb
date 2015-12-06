class Translate < ActiveRecord::Base
  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"

  yandex = YandexTranslate::Client.new(Key)
  Yandex_langs = yandex.get_langs["dirs"]

  validates :text, presence: true
  validates :translated_text, presence: true
  validates :lang, presence: true

  before_validation do
    self.translated_text = yandex.translate(text, lang).first if !translated_text.nil? && translated_text.empty?
  end

end
