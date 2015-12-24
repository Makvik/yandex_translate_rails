class YandexTranslatesController < ApplicationController
  before_filter :authenticate_user!

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
    @translate = Translate.new(translate_params, user_id: current_user.id)

    if @translate.save
      redirect_to :action => 'show', :id => @translate
    else
      render 'new'
    end
  end

  def update
    @translate = Translate.find_by(id: params[:id], user_id: current_user.id)

    if @translate.update(translate_params)
      redirect_to :action => 'show', :id => @translate
    else
      render 'edit'
    end
  end

  def destroy
    @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
    @translate.destroy
    redirect_to yandex_translates_path
  end

  private
    def translate_params
      params.require(:translate).permit(:text)
    end
end
