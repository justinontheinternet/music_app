# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs/' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new_song' do
  erb :'songs/new_song'
end