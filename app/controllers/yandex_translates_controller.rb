class YandexTranslatesController < ApplicationController
  def index
    @translates = Translate.all
  end

  def show
    @translate = Translate.find(params[:id])
  end

  def new
    @translate = Translate.new    
  end

  def edit
    @translate = Translate.find(params[:id])    
  end

  def create
    @translate = Translate.new(translate_params)

    if @translate.save
      redirect_to :action => 'show', :id => @translate
    else      
      render 'new'
    end    
  end

  def update
    @translate = Translate.find(params[:id])

    if @translate.update(translate_params)
      redirect_to :action => 'show', :id => @translate
    else      
      render 'edit'
    end 
  end

  def destroy
    @translate = Translate.find(params[:id])
    @translate.destroy
    redirect_to yandex_translates_path
  end

  private
    def translate_params
      params.require(:yandex_translates).permit(:text, :translated_text, :lang)
    end
  # def render_detect_or_translate_or_save(render_type, commit, text, translated_text, lang, id = 0)
  #   # Only treatment button "Detect language"
  #   if commit == "Detect language"
  #     @yandex_langs = Yandex_langs
  #     @translate = Translate.new
  #     if render_type == 'edit'
  #       @translate = Translate.find(id)
  #     end
  #     @translate.text = text
  #     if !translated_text.empty?
  #       @translate.translated_text = translated_text
  #     end
  #     @translate.lang_short = lang
  #     @translate.lang_long = convert_to_lang_long(lang)
  #     @detect_lang = Yandex.detect(text)
  #     render render_type
  #     return
  #   end

  #   # depending on the mode of load or create a resource
  #   @translate = Translate.new
  #   if render_type == 'edit'
  #     @translate = Translate.find(id)
  #   end
  #   @translate.text = text

  #   # Save or translate text
  #   if commit == "Save" && translated_text.empty?
  #     @translate.translated_text = translated_text
  #   else
  #     @translate.translated_text = Yandex.translate(text, lang).first
  #   end

  #   @translate.lang_short = lang
  #   @translate.lang_long = convert_to_lang_long(lang)

  #   if commit == "Save" && @translate.save
  #     redirect_to :action => "show", :id => @translate
  #   else
  #     @yandex_langs = Yandex_langs
  #     render render_type
  #   end
  # end 
end
