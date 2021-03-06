class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :photos,                 dependent:  :destroy
  has_many :favorites,              dependent:  :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                  foreign_key:  "follower_id",
                                    dependent:  :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key:  "followed_id",
                                    dependent:  :destroy
  has_many :following,                through:  :active_relationships, 
                                       source:  :followed
  has_many :followers,                through:  :passive_relationships, 
                                       source:  :followed
  validates :name, presence: true

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  #photo_idが存在しているかどうか　true→いいね！をはずす　false→いいね！をする　
  def already_favorited?(photo)
    self.favorites.exists?(photo_id: photo.id) 
  end
end
