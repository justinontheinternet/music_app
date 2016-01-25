# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new_song' do
  @song = Song.new
  erb :'songs/new_song'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new_song'
  end
end

# get '/songs/:id' do
#   @song = Song.find params[:id]
#   erb :'songs/deets'
# end