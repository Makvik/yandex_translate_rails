class YandexTranslatesController < ApplicationController
  def index
    @translates = Translate.all
  end

  def show
    @translate = Translate.find(params[:id])
  end

  def new
    yandex = YandexTranslate::Client.new(Key)
    #exapmle "en-ru" to "English - Russian"
    @yandex_langs = yandex.get_langs['dirs'].map do |value|
      split_value = value.split('-')
      value = Array.[](yandex.get_langs['langs'][split_value[0]] + " - " + yandex.get_langs['langs'][split_value[1]], value)
    end
    @translate = Translate.new
  end

  def create
    yandex = YandexTranslate::Client.new(Key)
    @translate = Translate.new do |t|
      t.text = params.require(:yandex_translates)['text']
      t.translated_text = yandex.translate(params.require(:yandex_translates)['text'], params.require(:yandex_translates)['lang']).first
      t.lang_short = params.require(:yandex_translates)['lang']
      split_lang = params.require(:yandex_translates)['lang'].split('-')
      t.lang_long = yandex.get_langs['langs'][split_lang[0]] + " - " + yandex.get_langs['langs'][split_lang[1]]
    end

    if @translate.save
      redirect_to :action => "show", :id => @translate
    else
      render 'new'
    end
  end

  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"
end
