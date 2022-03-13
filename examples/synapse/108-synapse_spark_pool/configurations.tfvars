
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
storage_data_lake_gen2_filesystem = {
  sdlg21 = {
    name = "example"
    storage_account = {
      key = "sa1"
    }
  }
}

synapse_workspace = {
  syws1 = {
    name = "example"
    resource_group = {
      key = "rg1"
    }
    location = "region1"
    storage_data_lake_gen2_filesystem = {
      key = "sdlg21"
    }
    sql_administrator_login          = "sqladminuser"
    sql_administrator_login_password = "H@Sh1CoR3!"
    tags = {
      Env = "production"
    }
  }
}

synapse_spark_pool = {
  sysp1 = {
    name = "example"
    synapse_workspace = {
      key = "syws1"
    }
    node_size_family = "MemoryOptimized"
    node_size        = "Small"
    cache_size       = 100

    auto_scale = {
      max_node_count = 50
      min_node_count = 3
    }

    auto_pause = {
      delay_in_minutes = 15
    }

    library_requirement = {
      content  = <<EOF
  appnope==0.1.0
  beautifulsoup4==4.6.3
  EOF
      filename = "requirements.txt"
    }

    spark_config = {
      content  = <<EOF
  spark.shuffle.spill                true
  EOF
      filename = "config.txt"
    }
  }
}