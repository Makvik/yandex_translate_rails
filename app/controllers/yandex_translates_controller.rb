class YandexTranslatesController < ApplicationController
  def index
    @translates = Translate.all
  end

  def show
    @translate = Translate.find(params[:id])
  end

  def new
    @translate = Translate.new
    @yandex_langs = Yandex_langs
  end

  def edit
    @translate = Translate.find(params[:id])
    @yandex_langs = Yandex_langs
  end

  def create
    @translate = Translate.new do |t|
      t.text = params.require(:yandex_translates)['text']
      t.translated_text = Yandex.translate(params.require(:yandex_translates)['text'], params.require(:yandex_translates)['lang']).first
      t.lang_short = params.require(:yandex_translates)['lang']
      split_lang = params.require(:yandex_translates)['lang'].split('-')
      t.lang_long = Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]]
    end

    if @translate.save
      redirect_to :action => "show", :id => @translate
    else
      @yandex_langs = Yandex_langs
      render 'new'
    end
  end

  def update
    @translate = Translate.find(params[:id]) do |t|
      t.text = params.require(:yandex_translates)['text']
      t.translated_text = Yandex.translate(params.require(:yandex_translates)['text'], params.require(:yandex_translates)['lang']).first
      t.lang_short = params.require(:yandex_translates)['lang']
      split_lang = params.require(:yandex_translates)['lang'].split('-')
      t.lang_long = Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]]
    end

    if @translate.save
      redirect_to :action => "show", :id => @translate
    else
      @yandex_langs = Yandex_langs
      render 'edit'
    end
  end

  def destroy
    @translate = Translate.find(params[:id])
    @translate.destroy

    redirect_to yandex_translates_path
  end

  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"
    Yandex = YandexTranslate::Client.new(Key)
    #exapmle "en-ru" to "English - Russian"
    Yandex_langs = Yandex.get_langs['dirs'].map do |value|
      split_value = value.split('-')
      value = Array.[](Yandex.get_langs['langs'][split_value[0]] + " - " + Yandex.get_langs['langs'][split_value[1]], value)
    end

end
