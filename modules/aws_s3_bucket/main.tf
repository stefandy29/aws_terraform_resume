resource "aws_s3_bucket" "keysersoze_bucket1" {
  bucket = var.s3_bucket_name
  tags = {
    Name = var.s3_tags
  }
}

resource "aws_s3_bucket_public_access_block" "keysersoze_bucket1_block_public_access" {
  bucket = aws_s3_bucket.keysersoze_bucket1.id

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

locals {
  content_types = {
    ".html" : "text/html",
    ".css" : "text/css",
    ".js" : "text/javascript"
  }
}

# Upload all object
resource "aws_s3_bucket_object" "keysersoze_bucket1_importobject1" {
  for_each     = fileset("${var.s3_folder_location_upload}/", "*")
  bucket       = aws_s3_bucket.keysersoze_bucket1.id
  key          = each.value
  source       = "${var.s3_folder_location_upload}/${each.value}"
  etag         = md5("${var.s3_folder_location_upload}/${each.value}")
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
}

resource "aws_s3_bucket_website_configuration" "keysersoze_bucket1_static" {
  bucket = aws_s3_bucket.keysersoze_bucket1.id

  index_document {
    suffix = var.s3_bucket_website_configuration_suffix
  }
}

# resource "local_file" "indexjs" {
#   content  = <<EOF
# function showItem(type){
#     let elements = document.querySelectorAll(`section`);
#     document.querySelectorAll('section').forEach(function(el) {
#       el.style.display = 'none';
#    });
#     elements.forEach(element => {
#         if (element.id == type) {
#           element.style.display = 'block';
#         }
#       });
# }

# async function getView() {
#   let lambda_url = "https://vmmyfl726h.execute-api.ap-southeast-3.amazonaws.com/views/totalViewer"
#   let response = await fetch(lambda_url,
#   {
#     headers: {
#       "Access-Control-Allow-Origin": "*", 
#       "Access-Control-Allow-Headers" : "*",
#       "Access-Control-Allow-Credentials": true,
#       "Access-Control-Allow-Methods": "POST, PUT, PATCH, GET, DELETE, OPTIONS",
#       "Content-Type": "application/json"
#     },
#     method: 'POST',
#   });

#   let jsondata = await response.text();
#   document.getElementById("dynamodb_view").innerText = jsondata.replaceAll('"', "");
# }
# getView()
# EOF
#   filename = "${path.root}/${var.s3_folder_location_upload}/${var.lambda_function_name}.py"
# }