class YandexTranslatesController < ApplicationController
  before_filter :authenticate_user!

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
      params.require(:translate).permit(:text)
    end
end
