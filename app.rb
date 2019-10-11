enable :sessions
enable :method_override

get '/' do
  @posts = Post.all
  slim :index
end

get '/create_article' do
  login_required
  csrf_token_generate

  @categories = Category.all
  slim :create_article
end

post '/article_post' do
  login_required
  redirect '/create_article' unless params[:csrf_token] == session[:csrf_token]

  file = params[:file]
  thumbnail_name = file ? file[:filename] : params[:thumbnail]

  @post = Post.new(
    category_id: params[:category_id],
    title:       params[:title],
    body:        params[:body],
    thumbnail:   thumbnail_name&.downcase
  )

  csrf_token_generate

  if @post.valid?
    if file
      File.open("public/img/#{@post.thumbnail}", 'wb') do |f|
        f.write(file[:tempfile].read)
      end
    end

    if params[:prev]
      @category_name = Category.find(@post.category_id).name
      slim :preview
    elsif params[:back]
      File.delete("public/img/#{params[:thumbnail]}")
      @categories = Category.all
      slim :create_article
    else
      @post.save
      redirect "/articles/#{@post.id}"
    end
  else
    @categories = Category.all
    slim :create_article
  end
end

get '/articles/:id' do
  @post = Post.find_by(id: params[:id])
  @category_name = Category.find(@post.category_id).name

  slim :articles
end

get '/login' do
  csrf_token_generate
  slim :login
end

post '/login' do
  redirect '/create_article' unless params[:csrf_token] == session[:csrf_token]

  user = User.find_by(name: params[:name])

  if user&.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/create_article'
  else
    slim :login
  end
end

delete '/logout' do
  login_required
  redirect '/create_article' unless params[:csrf_token] == session[:csrf_token]

  session.clear

  redirect '/login'
end
