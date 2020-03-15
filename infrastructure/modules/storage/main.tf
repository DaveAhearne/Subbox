resource "aws_dynamodb_table" "post_table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "PostId"
  range_key      = "Category"

  attribute {
    name = "PostId"
    type = "S"
  }

  attribute {
    name = "Category"
    type = "S"
  }
}