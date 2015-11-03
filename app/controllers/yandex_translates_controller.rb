class YandexTranslatesController < ApplicationController
  def new
    yandex = YandexTranslate::Client.new(Key)
    @yandex_langs = yandex.get_langs
    @yandex_langs['dir'].each |key, value|
      value = "en"
    end
  end

  def create
    yandex = YandexTranslate::Client.new(Key)
    render plain: yandex.translate(params.require(:yandex_translates)['text'], params.require(:lang))['text']
  end

  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"
end
