require 'aws-sdk-dynamodb'

class DynamoHandler

  def initialize
    access_key = ENV["AWS_ACCESS_KEY"]
    secret_key = ENV["AWS_SECRET_KEY"]

    @params = Hash.new()
    @params[:table_name] = "Tasks"

    @dynamodb_client = Aws::DynamoDB::Client.new(
        access_key_id:      access_key,
        secret_access_key:  secret_key,
        region:             "us-east-1"
      )
  end


  def params
    return @params
  end


  def add_item item
    @params[:item] = item
    params
  end


  def add_key item
    @params[:key] = item
    params
  end


  def add_update_expressions item
    add_key( { id: item[:id] })
    
    @params[:return_values]               = "UPDATED_NEW"
    @params[:update_expression]           = "set task_name = :n, task_description = :d"
    @params[:expression_attribute_values] = {
        ":n" => item[:task_name],
        ":d" => item[:task_description]
      }

    params
  end


  def scan
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.scan(params()).items }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def get_item item
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.get_item(add_key(item)).item }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def update_item item
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.update_item(add_update_expressions(item)) }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def put_item item
    begin
      @dynamodb_client.put_item(add_item(item))
      return { code: 200, message: "OK" }
      
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def delete_item item
    begin
      @dynamodb_client.delete_item(add_key(item))
      return { code: 200, message: "OK" }

    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end
end
