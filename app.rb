require "sinatra"
require "pry"
require_relative "dynamo_handler"


get '/to-do-list/api/tasks' do
  "GET ALL"
end

get '/to-do-list/api/tasks/:id' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.get_item(params).to_json()
end

# Nota:
# los params entran como form-data desde Postman
post '/to-do-list/api/tasks' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.put_item(params).to_json()
end

delete '/to-do-list/api/tasks' do
  "DELETE"
end