data_dir = "{{NOMAD_DIR}}"
bind_addr = "0.0.0.0"

advertise {
  http = "{{ADVERTISE_HTTP_ADDR}}"
  rpc  = "{{ADVERTISE_RPC_ADDR}}"
  serf = "{{ADVERTISE_SERF_ADDR}}"
}

client {
  enabled = true
  meta {
    name = "{{CLIENT_NAME}}"
  }

  servers = ["{{CLIENT_SERVER_ADDR_1}}"]
}

plugin "raw_exec" {
  config {
    enabled = true
    no_cgroups = true
  }
}

plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}