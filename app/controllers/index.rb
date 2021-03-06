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

get '/edit/:id' do
  @post = Post.find(params[:id])
  tags = []
  @post.tags.each { |tag| tags << tag.name }
  @tags = tags.join(', ')
  erb :edit
end

get '/delete/:id' do
  @post = Post.find(params[:id])
  erb :delete
end

get '/delete_post/:id' do
  Post.destroy(params[:id])
  redirect to ('/posts')
end

get '/tags' do
  tags = Tag.all
  tags.sort_by! { |tag| tag.name.downcase }
  @tags = tags.reject { |tag| tag.posts == [] }
  erb :tags
end

get '/tags/:name' do
  @tag = Tag.where(name: params[:name])[0]
  p @tag
  p @tag.name
  @posts = Post.includes(:tags).where("tags.name" => @tag.name)
  p @posts
  erb :tag
end

# =================================================================

post '/create_post' do
  puts params
  @post = Post.new(params[:post])
  @post.save
  @tags = (params[:tag][:names].split(',')).collect { |tag| tag.strip }
  @tags.each { |tag| @post.tags << Tag.find_or_create_by_name(tag) }
  redirect to ("/posts/#{@post.id}")
end

post '/edit_post/:id' do
  @post = Post.update(params[:id],params[:post])
  @tags = (params[:tag][:names].split(',')).collect { |tag| tag.strip }
  @post = Post.update(params[:id], :tags => [] )
  @tags.each { |tag| @post.tags << Tag.find_or_create_by_name(tag) }
  redirect to ("/posts/#{@post.id}")
end