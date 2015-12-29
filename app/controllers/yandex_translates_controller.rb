class YandexTranslatesController < ApplicationController

  def index
      @translates = Translate.all.where(user_id: current_user.id)
  end

  def show
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
  end

  def new
    @translate = Translate.new
  end

  def edit
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
  end

  def create
    @translate = Translate.new(text: translate_params[:text], user_id: current_user.id)

    if @translate.save
      redirect_to :action => 'show', :id => @translate
    else
      render 'new'
    end
  end

  def update
    @translate = Translate.find(params[:id])

    if @translate.user_id == current_user.id && @translate.update(text: translate_params[:text])
      redirect_to :action => 'show', :id => @translate
    else
      render 'edit'
    end
  end

  def destroy
    @translate = Translate.find(params[:id])
    @translate.destroy if @translate.user_id == current_user.id
    redirect_to yandex_translates_path
  end

  private
    def translate_params
      params.require(:translate).permit(:text)
    end
end
