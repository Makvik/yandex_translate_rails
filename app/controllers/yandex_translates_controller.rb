class YandexTranslatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.role == "admin"
      @translates = Translate.all
    else
      @translates = Translate.all.where(user_id: current_user.id)
    end
  end

  def show
    if current_user.role == "admin"
      @translate = Translate.find(params[:id])
    else
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
    end
  end

  def new
    @translate = Translate.new
  end

  def edit
    if current_user.role == "admin"
      @translate = Translate.find(params[:id])
    else
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
    end
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
    if current_user.role == "admin"
      @translate = Translate.find(params[:id])
    else
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
    end

    if @translate.update(text: translate_params[:text])
      redirect_to :action => 'show', :id => @translate
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.role == "admin"
      @translate = Translate.find(params[:id])
    else
      @translate = Translate.find_by(id: params[:id], user_id: current_user.id)
    end

    @translate.destroy
    redirect_to yandex_translates_path
  end

  private
    def translate_params
      params.require(:translate).permit(:text)
    end
end
