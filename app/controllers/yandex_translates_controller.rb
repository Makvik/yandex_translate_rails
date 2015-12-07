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

    if params.require(:commit) == "Detect language"
     detect_lang
     return
    end

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

  def detect_lang
    yandex = YandexTranslate::Client.new(Translate::Key)
    @detect_lang = yandex.detect(params.require(:yandex_translate).permit(:text)).downcase

    render 'edit'
  end

  def update_lang
    # @yandex_lang = City.where("country_id = ?", params[:country_id])
    # respond_to do |format|
    #   format.js
    # end
  end

  private
    def translate_params
      params.require(:yandex_translate).permit(:text, :translated_text, :lang)
    end
end
