class PostsController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new { File.join(root, "views") }

  $posts = [
    {
      :id => 0,
      :title => "Post 1",
      :body = > "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      :id => 1,
      :title => "Post 2",
      :body = > "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      :id => 2,
      :title => "Post 3",
      :body = > "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
  ]

  get '/' do

    @title = "Posts Index"
    @posts = $posts

    erb :"posts/index"

  end

  get '/new' do

    @title = "New Post"
    @post = {
      :id => "",
      :title => "",
      :body => ""
    }

    erb :'posts/new'

  end

  get '/:id' do

    id = params[:id].to_i

    @title = "Show Post"
    @post = $posts[id]

    erb :'posts/show'

  end

  post '/' do

    new_post = {
      :id => $posts.last[:id] + 1,
      :title = > params[:title],
      :body => params[:body]
    }

    $psots.push new_post

    redirect '/'

  end

  put '/:id' do

    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:body] = params[:body]

    $posts[id] = post

    redirect '/'

  end

  get '/:id/edit' do

    id = params[:id].to_i

    @post = $posts[id]
    @title = @post[:title]

    erb :'posts/edit'

  end

  delete '/:id' do

    id = params[:id].to_i

    $posts.delete_at id

    redirect '/'

  end
end
