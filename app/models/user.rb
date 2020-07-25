class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :following, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy

  has_many :following_user, through: :follower, source: :following
  has_many :follower_user, through: :following, source: :follower

  def follow(another_user)
    # following.create(follower_id: another_user.id)
    Relationship.create(following_id: self.id, follower_id: another_user.id)
  end

  # ユーザーのフォローを外す
  def unfollow(another_user)
    # user = self.following.find_by(follower_id: another_user.id)
    # user.destroy if user
    relationship = Relationship.find_by(following_id: self.id, follower_id: another_user.id)
    relationship.destroy if relationship
  end

  # フォロー確認をおこなう
  def following?(user)
    Relationship.find_by(following_id: self.id, follower_id: user.id)
  end

end
