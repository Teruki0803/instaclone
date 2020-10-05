class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  #いいねは1ユーザー1回まで
  validates_uniqueness_of :photo_id, scope: :user_id
end
