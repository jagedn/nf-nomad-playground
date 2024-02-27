type = "csi"
id = "juicefs-volume"
name = "juicefs-volume"

capability {
access_mode = "multi-node-multi-writer"
attachment_mode = "file-system"
}
plugin_id = "juicefs0"

secrets {
  name="juicefs-volume"
  metaurl="sqlite3://myjfs.db"
  bucket="https://nf-nomad.s3.eu-west-1.amazonaws.com"
  storage="s3"
  access-key="XXXXXXXXXXXxxxx"
  secret-key="YYYYYYYYYYYYYYYYYYYYYYYYYY"
}
