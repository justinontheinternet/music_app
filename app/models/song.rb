class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :author, presence: true
  
end