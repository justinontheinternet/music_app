class AddReferencesToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.integer :upvotes
    end

    add_reference :songs, :user
  end
end
