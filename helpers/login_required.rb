helpers do
  def login_required
    redirect '/login' if session[:user_id].nil?
  end
end
