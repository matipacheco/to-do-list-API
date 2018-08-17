require 'aws-sdk-dynamodb'

# AWS Config.
# https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/setup-config.html

access_key = "AKIAJILQSHSCIKTN5TCA"
secret_key = "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"

dynamodb = Aws::DynamoDB::Client.new(
    access_key_id:      access_key,
    secret_access_key:  secret_key,
    region:             'us-east-1'
  )

item = {
  id:           "1",
  name:         "Yo",
  description:  "+56932543157"
}

params = {
  table_name: 'Tasks',
  item:       item
}

begin
  result = dynamodb.put_item(params)
  puts 'Added Task'

rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add movie:'
  puts error.message

end