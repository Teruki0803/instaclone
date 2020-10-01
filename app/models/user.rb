class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :photos,                 dependent:  :destroy
  has_many :favorites,              dependent:  :destroy
  #photo_idが存在しているかどうか　true→いいね！をはずす　false→いいね！をする　
  def already_favorited?(photo)
    self.favorites.exists?(photo_id: photo.id) 
  end
end
