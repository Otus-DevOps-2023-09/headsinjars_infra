
terraform {


  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "tf-remote"
    region   = "ru-central1"
    key      = "stage/terraform.tfstate"
    # look readme.md to add export keys
    skip_region_validation      = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g8t8ui708klmdt9pg9/etnhis2gdne5kf1tr4ja"
    dynamodb_table    = "table922"
  }
}

