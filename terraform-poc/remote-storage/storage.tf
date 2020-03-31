resource "aws_s3_bucket" "remote-state-storage" {
    bucket = "terraform-remote-state-storage-nexworld"

    versioning {
        enabled = true
    }

    # Prevent bucket from being destroy
    lifecycle {
        prevent_destroy = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }

}

resource "aws_dynamodb_table" "lock-for-s3" {
    name = "lock-terraform-remote-storage"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"

    attribute {
        name = "LockID"
        type = "S"
    }
}