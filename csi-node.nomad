job "jfs-node" {
  datacenters = ["dc1"]
  type = "system"

  group "nodes" {
    task "juicefs-plugin" {
      driver = "docker"

      config {
        image = "juicedata/juicefs-csi-driver:v0.14.1"

        args = [
          "--endpoint=unix://csi/csi.sock",
          "--logtostderr",
          "--v=5",
          "--nodeid=test",
          "--by-process=true",
        ]

        privileged = true
      }

      csi_plugin {
        id        = "juicefs0"
        type      = "node"
        mount_dir = "/csi"
      }
      resources {
        cpu    = 1000
        memory = 1024
      }
      env {
        POD_NAME = "csi-node"
      }
    }
  }
}
