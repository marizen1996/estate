class Post < ApplicationRecord
  
  belongs_to :user
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  
  validates :property_name, presence: true
  validates :image, presence: true
  

    def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
    end
    
    def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
    end
    
    def gooded_by?(user)
    goods.exists?(user_id: user.id)
    end
    
    
end
