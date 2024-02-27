# Playground for nf-nomad plugin

## Setup a nomad cluster

`sudo nomad agent -config server.conf -config client.conf`

`nomad run csi-controller.nomad`

`nomad run csi-node.nomad`

Create a volume. I'll use an S3 bucket as storage

`nomad volume create volume.hcl`

## Using a Docker volume

Using an NFS server, create a docker volume

`docker volume create --driver local -o type=nfs  -o o=addr=YOUR_SERVER,nfsvers=4   -o device=:/home/jorge/edn/nextflow/nfs/workdir   nfs-test`

`cd examples/docker`

`nextflow run main.nf`

nextflow + nomad + jobs + tasks, all of them will use this NFS as share storage

## Using Nomad Volume

`cd examples/as-jobs`

`nomad run job-rnaseq.nomad`

Nextflow will be executed "into" the cluster using a nomad volume and will execute pipelines mounting this volume
