class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :songs

  validates :user_id, presence: true
  validates :song_id, presence: true

  def already_voted?
    Upvote.find_by user_id: user_id, song_id: song_id
  end

end