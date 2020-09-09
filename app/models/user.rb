class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :follower, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followed, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  attachment :profile_image, destroy: false

  #geocoded_by :address
  #after_validation :geocode, if: :address_changed?

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true


  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  #ユーザーのフォローを解除する
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #すでにフォロー済みであればture返す
  def following?(user)
    following_user.include?(user)
  end

  def self.search(search,word)
        if    search == "perfect_match"
                        @user = User.where(name: "#{word}")
        elsif search == "backward_match"
                        @user = User.where("name LIKE?","%#{word}")
        elsif search == "forward_match"
                        @user = User.where("name LIKE?","#{word}%")
        elsif search == "partial_match"
                        @user = User.where("name LIKE?","%#{word}%")
        else
                        @user = User.all
        end
  end

  include JpPrefecture
  jp_prefecture :prefect_code

  def prefectture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end
