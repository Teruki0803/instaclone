class Photo < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :favorites, dependent: :destroy 

  with_options presence: true do
    #タイトル、本文、画像がないと投稿できないようにする
    validates :title
    validates :body
  
  end
end
