class PhotosController < ApplicationController
  protect_from_forgery 
  before_action :authenticate_user!, except: [:index]
  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    @photo = Photo.find_by(id: params[:id])
    @microposts = @photo.microposts
  end

  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to photo_path(@photo)
    else 
      render :new #アクションを返さずViewへ
    end      
  end

  def edit
    @photo = Photo.find(params[:id])
    #ログインしているアカウントと同一でない場合、リダイレクト
      if @photo.user != current_user
        redirect_to photos_path, alert: "不正なアクセスです"
      end
  end
  
  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)
    redirect_to photo_path(@photo)
  end
  
  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to photos_path
  end
  
  private
  def photo_params
    params.require(:photo).permit(:title, :body, :image)
  end  
end