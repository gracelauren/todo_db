require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

DB = PG.connect({:dbname => "todo"})

get("/") do
  @lists = List.all()
  erb(:index)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  redirect("/")
end

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  due = params.fetch("due")
  list_id = params.fetch("list_id").to_i()
  task = Task.new({:description => description, :due => due, :list_id => list_id})
  task.save()
  @list = List.find(list_id)
  erb(:list)
  # url = "/lists/:" + list_id.to_s()
  # redirect(url)
end
