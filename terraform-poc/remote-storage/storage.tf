resource "aws_s3_bucket" "remote-state-storage" {
    bucket = "terraform-remote-state-storage-nexworld"

    versioning {
        enabled = true
    }

    # Prevent bucket from being destroy
    lifecycle {
        prevent_destroy = true
    }

}

resource "aws_dynamodb_table" "lock-for-s3" {
    name = "lock-terraform-remote-storage"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20

    attribute {
        name = "LockID"
        type = "S"
    }
}