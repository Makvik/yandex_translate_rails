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
    render_detect_or_translate_or_save('new',
                      params.require(:commit),
                      params.require(:yandex_translates)['text'],
                      params.require(:yandex_translates)['translated_text'],
                      params.require(:yandex_translates)['lang'])
  end

  def update
    render_detect_or_translate_or_save('edit',
                      params.require(:commit),
                      params.require(:yandex_translates)['text'],
                      params.require(:yandex_translates)['translated_text'],
                      params.require(:yandex_translates)['lang'],
                      params[:id])
  end

  def destroy
    @translate = Translate.find(params[:id])
    @translate.destroy
    redirect_to yandex_translates_path
  end

  def render_detect_or_translate_or_save(render_type, commit, text, translated_text, lang, id = 0)
    # Only treatment button "Detect language"
    if commit == "Detect language"
      @yandex_langs = Yandex_langs
      @translate = Translate.new
      if render_type == 'edit'
        @translate = Translate.find(id)
      end
      @translate.text = text
      if !translated_text.empty?
        @translate.translated_text = translated_text
      end
      @translate.lang_short = lang
      @translate.lang_long = convert_to_lang_long(lang)
      @detect_lang = Yandex.detect(text)
      render render_type
      return
    end

    # depending on the mode of load or create a resource
    @translate = Translate.new
    if render_type == 'edit'
      @translate = Translate.find(id)
    end
    @translate.text = text

    # Save or translate text
    if commit == "Save" && translated_text.empty?
      @translate.translated_text = translated_text
    else
      @translate.translated_text = Yandex.translate(text, lang).first
    end

    @translate.lang_short = lang
    @translate.lang_long = convert_to_lang_long(lang)

    if commit == "Save" && @translate.save
      redirect_to :action => "show", :id => @translate
    else
      @yandex_langs = Yandex_langs
      render render_type
    end
  end

  def convert_to_lang_long(lang)
    split_lang = lang.split('-')
    return Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]]
  end

  private
    Key = "trnsl.1.1.20150807T193721Z.a28754c35f356a3c.9887c0360b34c7c397a5f114144c28840912b234"
    Yandex = YandexTranslate::Client.new(Key)
    # "en-ru" to "English - Russian"
    Yandex_langs = Yandex.get_langs['dirs'].map do |value|
      split_lang = value.split('-')
      value = Array.[](Yandex.get_langs['langs'][split_lang[0]] + " - " + Yandex.get_langs['langs'][split_lang[1]], value)
    end
end
