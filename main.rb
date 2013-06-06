require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'localhost',
  :username => 'harrisontan',
  :password => '',
  :database => 'todo',
  :encoding => 'utf8'
)

require_relative "task"

get "/" do
  @tasks = Task.all
  erb :index
end

get "/new_task" do
  erb :new_task
end

post "/new_task" do
  @task = Task.new(:task => params[:task_task], :details => params[:task_details])

  if @task.save
    redirect "/"
  else
    erb :new_task
  end
end

get "/edit_task/:task_id" do
  @task = Task.find_by_id(params[:task_id])
  erb :edit_task
end

post "/save_task/:task_id" do
  @task = Task.find_by_id(params[:task_id])

  if @task.update_attributes(:task => params[:task_task], :details => params[:task_details])
    redirect "/"
  else
    erb :edit_task
  end
end

get "/complete_task/:task_id" do
  @task = Task.find_by_id(params[:task_id])
  @task.update_attributes(:completed => true)
  redirect "/"
end

get "/completed_tasks" do
  @tasks = Task.all
  erb :completed_tasks
end

get "/put_back_task/:task_id" do
  @task = Task.find_by_id(params[:task_id])
  @task.update_attributes(:completed => false)
  redirect "/completed_tasks"
end


























