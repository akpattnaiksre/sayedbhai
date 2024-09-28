locals {
  # Flatten the nested containers_folders map into a list of maps with required values
  container_map = flatten([
    for rg_key, rg_value in var.resource_group_map : [
      for container_name, container in rg_value.containers_folders : {
        rg_key          = rg_key
        storage_account = rg_key
        container_name  = container_name
      }
    ]
  ])
}
