require "sinatra"
require "pry"
require_relative "dynamo_handler"

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