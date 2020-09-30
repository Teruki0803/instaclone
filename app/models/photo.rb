class Photo < ApplicationRecord
  belongs_to :user
  attachment :image
end
