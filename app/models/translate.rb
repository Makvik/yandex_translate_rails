class Translate < ActiveRecord::Base
  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"

  yandex = YandexTranslate::Client.new(Key)
  Yandex_langs = split_langs()


  validates :text, presence: true
  validates :translated_text, presence: true
  validates :lang, presence: true

  before_validation do
    self.translated_text = yandex.translate(text, lang).first if !translated_text.nil? && translated_text.empty?
  end

  def split_langs
    hash = {}
    yandex.get_langs['dirs'].map do |value|
      split_lang = value.split('-')
      if hash.has_key?(split_lang[0])
        hash[split_lang[0]] = hash[split_lang[0]].push({split_lang[1] => value})
      else
        hash[split_lang[0]] = [ {split_lang[1] => value} ]
      end
    end
    return hash
  end

end
