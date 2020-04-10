terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  version = "=2.4.0" 
  skip_provider_registration = "true"
}

data "azurerm_client_config" "current" {}

  resource "azurerm_resource_group" "bigdatarg" {
  name     = "bigdatarg"
  location = "northeurope"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_storage_account" "bigdatasa" {
  name                     = "bigdatargsa"
  resource_group_name      = "${azurerm_resource_group.bigdatarg.name}"
  location                 = "${azurerm_resource_group.bigdatarg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_storage_container" "bigdatasc" {
  name                  = "taxidata"
  resource_group_name   = "${azurerm_resource_group.bigdatarg.name}"
  storage_account_name  = "${azurerm_storage_account.bigdatasa.name}"
  container_access_type = "private"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_data_factory" "bigdataadf" {
  name                = "bigdataadfdt"
  location            = "${azurerm_resource_group.bigdatarg.location}"
  resource_group_name = "${azurerm_resource_group.bigdatarg.name}"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_databricks_workspace" "bigdatadb" {
  name                = "bigdatadb"
  resource_group_name = "${azurerm_resource_group.bigdatarg.name}"
  location            = "${azurerm_resource_group.bigdatarg.location}"
  sku                 = "standard"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_sql_server" "bigdataserver" {
  name                         = "bigdataserversor"
  resource_group_name          = "${azurerm_resource_group.bigdatarg.name}"
  location                     = "northeurope"
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_sql_database" "bigdataserverdb" {
  name                = "bigdataserverdb"
  resource_group_name = "${azurerm_resource_group.bigdatarg.name}"
  location            = "northeurope"
  server_name         = "${azurerm_sql_server.bigdataserver.name}"
  create_mode         = "Default"
  edition             = "DataWarehouse"
  requested_service_objective_name = "DW100c"
  
  tags = {
    project = aghbigdata
  }
}

resource "azurerm_analysis_services_server" "server" {
  name                    = "analysisservicesserver"
  location                = "northeurope"
  resource_group_name     = "${azurerm_resource_group.bigdatarg.name}"
  sku                     = "D1"
  admin_users             = ["Krzysztof.Nojman@os.uk"]
  enable_power_bi_service = true

  ipv4_firewall_rule {
    name        = "localip"
    range_start = "98.158.250.0"
    range_end   = "98.158.250.255"
  }

  tags = {
    project = aghbigdata
  }
}
