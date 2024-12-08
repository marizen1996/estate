class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_one_attached :profile_image
         
         
   GUEST_USER_EMAIL = "guest@example.com"

   def self.guest
     find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
       user.password = SecureRandom.urlsafe_base64
       user.name = "guestuser"
   end
 end
 
 
 def update_without_current_password(params, *options)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  
  
         has_many :posts, dependent: :destroy
         has_many :post_comments, dependent: :destroy
         has_many :goods, dependent: :destroy
         
         
         
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  
  end 
  
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @user = User.where("name LIKE?", "#{word}")
  #   elsif search == "forward_match"
  #     @user = User.where("name LIKE?","#{word}%")
  #   elsif search == "backward_match"
  #     @user = User.where("name LIKE?","%#{word}")
  #   elsif search == "partial_match"
  #     @user = User.where("name LIKE?","%#{word}%")
  #   else
  #     @user = User.all
  #   end
  # end
  
   def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  
end 
