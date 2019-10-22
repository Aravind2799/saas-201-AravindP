require 'sinatra'
# Your app

def get_todos
  @@todos ||= []
end

def add_todo(todo, deadline)
  get_todos().push({todo=>deadline})
end

get "/todos" do
  @todos = get_todos()
  erb :todos
end

post "/todos" do
  add_todo(params[:title], params[:date])
  redirect "/todos"
end

def get_todo
  get_todos()[@id.to_i - 1]
end

get "/todos/:id" do
  @id = params[:id]
  @todo = get_todo()
  erb :todo
end

def update_todo(title)
  get_todos()[@id.to_i - 1] = {title=>get_todos()[@id.to_i - 1].values[0]}
end

put "/todos/:id" do
  @id = params[:id]
  update_todo(params[:title])
  redirect "/todos"
end

def delete_todo
  get_todos().slice!(@id.to_i - 1)
end

delete "/todos/:id" do
  @id = params[:id]
  delete_todo()
  redirect "/todos"
end