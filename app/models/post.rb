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
    
    # def self.looks(search, word)
    # if search == "perfect_match"
    #   @post = Post.where("title LIKE?","#{word}")
    # elsif search == "forward_match"
    #   @post = Post.where("title LIKE?","#{word}%")
    # elsif search == "backward_match"
    #   @post = Post.where("title LIKE?","%#{word}")
    # elsif search == "partial_match"
    #   @post = Post.where("title LIKE?","%#{word}%")
    # else
    #   @post = Post.all
    # end
    # end
    
      def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end
    
    
end
