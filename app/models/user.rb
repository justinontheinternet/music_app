class User < ActiveRecord::Base

  has_many :songs
  has_many :upvotes

  validates :user_name,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true

end