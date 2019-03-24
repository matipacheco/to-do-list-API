require 'sinatra'
require 'sinatra/cross_origin'
require_relative 'lib/dynamo_handler'

configure do
  enable :cross_origin
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accep'
  200
end

# Get all the Tasks
get '/to-do-list/api/tasks' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.scan().to_json()
end

# Get an specific Task
get '/to-do-list/api/tasks/:id' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.get_item(params).to_json()
end

# Update an specific Task
# Nota: los params entran como form-data desde Postman
put '/to-do-list/api/tasks/:id' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.update_item(params).to_json()
end

# Create a Task
# Nota: los params entran como form-data desde Postman
post '/to-do-list/api/tasks' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.put_item(params).to_json()
end

# Delete a Task
# Nota: los params entran como form-data desde Postman
delete '/to-do-list/api/tasks' do
  dynamo_handler = DynamoHandler.new()
  dynamo_handler.delete_item(params).to_json()
end