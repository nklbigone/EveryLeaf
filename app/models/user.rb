class User < ApplicationRecord
  has_secure_password
  validates :fname, presence: true, length: { maximum: 30 }
  validates :lname, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  def self.count_admins
    @users = User.all
    @admins=0
    @users.each do |user|
      if user.user_type == 'admin'
        @admins += 1
      end
    end
    return @admins
  end
end
