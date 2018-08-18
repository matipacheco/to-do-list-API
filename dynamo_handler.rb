require 'aws-sdk-dynamodb'

class DynamoHandler

  def initialize
    access_key = "AKIAJILQSHSCIKTN5TCA"
    secret_key = "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"

    @params = Hash.new()
    @params[:table_name] = "Tasks"

    @dynamodb_client = Aws::DynamoDB::Client.new(
        access_key_id:      access_key,
        secret_access_key:  secret_key,
        region:             "us-east-1"
      )
  end

  def default_params
    return @params
  end

  def format_item_params item
    @params[:item] = item
    return @params
  end

  def format_key_params item
    @params[:key] = item
    return @params
  end

  def format_update_params item
    format_key_params( { id: item[:id] })
    
    @params[:return_values]               = "UPDATED_NEW"
    @params[:update_expression]           = "set task_name = :n, task_description = :d"
    @params[:expression_attribute_values] = {
        ":n" => item[:task_name],
        ":d" => item[:task_description]
      }
    
    return @params
  end


  def scan
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.scan(default_params()).items }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def get_item item
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.get_item(format_key_params(item)).item }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def update_item item
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.update_item(format_update_params(item)) }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def put_item item
    begin
      @dynamodb_client.put_item(format_item_params(item))
      return { code: 200, message: "OK" }
      
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def delete_item item
    begin
      @dynamodb_client.delete_item(format_key_params(item))
      return { code: 200, message: "OK" }

    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end
end