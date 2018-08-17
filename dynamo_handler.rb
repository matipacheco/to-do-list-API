require 'json'
require 'aws-sdk-dynamodb'

class DynamoHandler

  def initialize
    access_key = "AKIAJILQSHSCIKTN5TCA"
    secret_key = "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"

    @table_name      = "Tasks"
    @dynamodb_client = Aws::DynamoDB::Client.new(
        access_key_id:      access_key,
        secret_access_key:  secret_key,
        region:             'us-east-1'
      )
  end


  def format_put_params item
    return {
              item: item,
              table_name: @table_name
            }
  end

  def format_get_params item
    return {
              key: item,
              table_name: @table_name
            }
  end

  # def format_update_params item
  #   return {
  #             key: {
  #                     id: item[:id]
  #                   },
  #             update_expression: "set info.name = :n, info.description = :d",
  #             expression_attribute_values: {
  #               ":n"        => item[:name],
  #               ":d" => item[:description]
  #             },
  #             return_values: "UPDATED_NEW",
  #             table_name: @table_name 
  #           }
  # end


  # def query item
  #   begin
  #     binding.pry
  #     return { code: 200, message: "OK", payload: @dynamodb_client.query({table_name: @table_name }).items }
       
  #   rescue  Aws::DynamoDB::Errors::ServiceError => error
  #     return { code: 500, message: error.message }

  #   end
  # end


  def get_item item
    begin
      return { code: 200, message: "OK", payload: @dynamodb_client.get_item(format_get_params(item)).item }
       
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  # def update_item item
  #   begin
  #     binding.pry
  #     return { code: 200, message: "OK", payload: @dynamodb_client.update_item(format_update_params(item)) }
       
  #   rescue  Aws::DynamoDB::Errors::ServiceError => error
  #     return { code: 500, message: error.message }

  #   end
  # end

  def put_item item
    begin
      @dynamodb_client.put_item(format_put_params(item))
      return { code: 200, message: "OK" }
      
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end


  def delete_item item
    begin
      @dynamodb_client.delete_item(format_get_params(item))
      return { code: 200, message: "OK" }

    rescue  Aws::DynamoDB::Errors::ServiceError => error
      return { code: 500, message: error.message }

    end
  end
end