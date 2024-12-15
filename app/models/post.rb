class Post < ApplicationRecord

  belongs_to :user
  # has_one_attached :image

  has_many :post_comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many_attached :images

  validates :property_name, presence: true
  validates :images, presence: true


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

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(caption: content)
    elsif method == 'forward'
      Post.where('caption LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('caption LIKE ?', '%'+content)
    else
      Post.where('caption LIKE ?', '%'+content+'%')
    end
  end

end
