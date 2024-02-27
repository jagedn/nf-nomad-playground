 job "nf-hello-job" {

  type        = "batch"

  group "nf-group" {

    volume "juicefs-volume" {
      type            = "csi"
      source          = "juicefs-volume"
      read_only       = false
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
      per_alloc       = false

      mount_options {
        fs_type     = "ext4"
        mount_flags = ["noatime"]
      }
    }

    restart {
      attempts = 1
      interval = "24h"
    }


    task "nf-task" {
      driver = "docker"

      template{
        destination = "local/main.nf"
        data = file("./main.nf")
      }
      template{
        destination = "local/nextflow.config"
        data = file("./nextflow.config")
      }

      env{
        NXF_PLUGINS_TEST_REPOSITORY="https://edn.es/nf-nomad-0.0.2-rc1-meta.json"
      }

      config {
        image = "nextflow/nextflow:23.11.0-edge"

        command = "bash"
        args    = ["-c", "NXF_ASSETS=/home/nextflow/assets nextflow run nextflow-io/rnaseq-nf  -with-docker -w /home/nextflow -cache false"]
        work_dir = "/local"

        mounts = [
          {
            type   = "bind"
            source = "local/main.nf"
            target = "/local/main.nf"
          },{
            type   = "bind"
            source = "local/nextflow.config"
            target = "/local/nextflow.config"
          },
        ]
      }

      volume_mount {
        volume      = "juicefs-volume"
        destination = "/home/nextflow"
      }

    }
  }
}
