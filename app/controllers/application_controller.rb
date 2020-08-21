class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/" do

  end

  get "/recipes" do 

    @recipe = Recipe.all

    erb :index

  end

  get "/recipes/new" do

    erb :new

  end

  post "/recipes" do
    #binding.pry
    @recipe = Recipe.create( name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    #@recipe.save

    redirect "/recipes/#{@recipe.id}"

  end

  get "/recipes/:id" do

    @recipe = Recipe.find_by(id: params[:id])

    erb :show

  end

  get "/recipes/:id/edit" do

    @recipe = Recipe.find_by(id: params[:id])

    erb :edit

  end


  patch "/recipes/:id" do 

    @recipe = Recipe.find_by(id: params[:id])

    if @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
      redirect "/recipes/#{@recipe.id}"
    else
      render :edit
    end
  end

  delete "/recipes/:id" do

    @recipe = Recipe.find_by(id: params[:id])

    @recipe.delete

    redirect "./index"

  end

end
