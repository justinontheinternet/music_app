class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :songs

  validates :user_id, uniqueness: true

end