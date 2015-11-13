class Translate < ActiveRecord::Base
  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"

  yandex = YandexTranslate::Client.new(Key)
  Yandex_langs = yandex.get_langs['dirs']


  validates :text, presence: true
  validates :translated_text, presence: true
  validates :lang, presence: true

  before_validation do
    self.translated_text = yandex.translate(text, lang).first if !translated_text.nil? && translated_text.empty?
  end

  # protected
	 #  def convert_to_lang_long(lang)
	 #    split_lang = lang.split('-')
	 #    return Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]]
	 #  end


  # "en-ru" to "English - Russian"

  # .map do |value|
  #   split_lang = value.split('-')
  #   value = Array.[](Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]], value)
  # end
end
