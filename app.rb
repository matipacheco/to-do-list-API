require "sinatra"


get '/to-do-list/api/tasks' do
  "GET ALL"
end

get '/to-do-list/api/tasks/:id' do
  "GET SINGLE " + params[:id]
end



post '/to-do-list/api/tasks' do
  "POST"
end

delete '/to-do-list/api/tasks' do
  "DELETE"
end