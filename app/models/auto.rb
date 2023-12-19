class Auto < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  has_many :comments, :dependent => :destroy
  
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3}
  validates :car_text, presence: true, length: {minimum: 0}
  
end
