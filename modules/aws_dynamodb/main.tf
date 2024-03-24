resource "aws_dynamodb_table" "keysersoze_dynamodb_views" {
  name           = var.dynamodb_name
  billing_mode   = "PROVISIONED"
  hash_key       = var.dynamodb_hashkey
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = var.dynamodb_hashkey
    type = "S"
  }

  tags = {
    name = var.dynamodb_tags
  }
}

resource "aws_dynamodb_table_item" "keysersoze_dynamodb_table" {
  table_name = aws_dynamodb_table.keysersoze_dynamodb_views.name
  hash_key   = aws_dynamodb_table.keysersoze_dynamodb_views.hash_key

  item = <<ITEM
{
  "${aws_dynamodb_table.keysersoze_dynamodb_views.hash_key}": {
    "S": "1"
  },
  "${var.dynamodb_item_key}": {
    "N": "0"
  }
}
ITEM
}