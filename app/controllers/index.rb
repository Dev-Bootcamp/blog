get '/' do
  erb :index
end

get '/posts' do
  @posts = Post.all
  erb :posts  
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :post
end

get '/create_post' do
  erb :create_post
end

# ==================================

post '/create_post' do
  puts params
  @post = Post.new(params[:post])
  @post.save
  Tag.new(params[:tag][:names])
  redirect to ("/posts/#{@post.id}")
end