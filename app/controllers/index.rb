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
  erb :construction
end
