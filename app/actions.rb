helpers do
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end

# Homepage (Root path)
get '/' do
  @user = current_user || User.new
  erb :index
end

# List all songs
get '/songs' do
  @songs = Song.all.joins('LEFT JOIN upvotes ON (songs.id = upvotes.song_id)').group("songs.id").order("COUNT(upvotes.song_id) DESC")
  erb :'songs/index'
end

# If user is logged in, he can post. If not, home page.
get '/songs/new_song' do
  if current_user
    @song = Song.new
    erb :'songs/new_song'
  else
    redirect '/'
  end
end

# Takes the params sent by 'new song' form.
post '/songs' do
  if current_user
    @song = Song.new(
      title: params[:title],
      author: params[:author],
      url: params[:url],
      user_id: current_user.id
    )
    @song.save
    redirect '/songs'
  else
    redirect '/'
  end
end

# gets :id param from action in songs/index.
#so address is actually /songs/(song.id)/upvote
post '/songs/:id/upvote' do
  user_id = current_user.id
  song_id = params[:id]
  @upvote = Upvote.new(user_id: user_id, song_id: song_id)
  if @upvote.already_voted?
    redirect '/songs'
  else
    @upvote.save
    redirect '/songs'
  end

end

# Find user, or create on if not found.
# If found, tie session to user.id.
# Else, render index to that @user errors can be shown
post '/validation' do
  user_name = params[:user_name]
  password = params[:password]
  @user = User.find_or_create_by(user_name: user_name, password: password)
  if @user.save
    session[:user_id] = @user.id
    redirect '/songs'
  else
    erb :index
  end
end

# End session
get '/logout' do
  session.delete(:user_id)
  redirect'/'
end
