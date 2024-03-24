resource "local_file" "javascript" {
  content  = <<EOF
function showItem(type){
    let elements = document.querySelectorAll(`section`);
    document.querySelectorAll('section').forEach(function(el) {
      el.style.display = 'none';
   });
    elements.forEach(element => {
        if (element.id == type) {
          element.style.display = 'block';
        }
      });
}

async function getView() {
  let lambda_url = "${var.api_gateway_url}"
  let response = await fetch(lambda_url,
  {
    headers: {
      "Access-Control-Allow-Origin": "*", 
      "Access-Control-Allow-Headers" : "*",
      "Access-Control-Allow-Credentials": true,
      "Access-Control-Allow-Methods": "POST, PUT, PATCH, GET, DELETE, OPTIONS",
      "Content-Type": "application/json"
    },
    method: 'POST',
  });

  let jsondata = await response.text();
  document.getElementById("dynamodb_view").innerText = jsondata.replaceAll('"', "");
}
getView()
EOF
  filename = "${path.root}/${var.s3_folder_location_upload}/index.js"
}