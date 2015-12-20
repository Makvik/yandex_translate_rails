class Translate < ActiveRecord::Base
  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"

  yandex = YandexTranslate::Client.new(Key)


  validates :text, presence: true
  validates :translated_text, presence: true
  validates :lang, presence: true

  before_validation do
    self.lang = "en-ru"
    self.lang = "ru-en" if yandex.detect(text) == 'ru'
    self.translated_text = yandex.translate(text, lang)
  end
end
