# Azure Networking Module

This Terraform module is used to manage Azure networking resources. 

## Resources

The module manages the following resources:

1. **Azure Virtual Network (VNet)**: Fetches the details of an existing VNet using its name and resource group name.

2. **Azure Subnets**: Creates multiple subnets within the VNet. The details of the subnets (name, CIDR block, delegation, service endpoints) are provided through the `var.subnets` variable. The `delegation` block within this resource is used to delegate subnet services to a specific service in Azure, and the `service_endpoints` property is used to link services directly to the subnet.

3. **Network Security Group (NSG) Association**: Associates a NSG with each of the subnets created. The NSG ID is provided through the `var.nsg_id` variable.

4. **Route Table Association**: Associates a Route Table with each of the subnets created. The Route Table ID is provided through the `var.route_table_id` variable.

## Usage

To use this module, you need to provide the following variables:

- `vnet_name`: The name of the existing VNet.
- `resource_group_name`: The name of the resource group where the VNet is located.
- `subnets`: A list of subnets to be created, each with properties for name, CIDR block, delegation, and service endpoints.
- `nsg_id`: The ID of the NSG to be associated with the subnets.
- `route_table_id`: The ID of the Route Table to be associated with the subnets.

## Summary

In summary, this Terraform module is used to create subnets within an existing VNet, and then associate each subnet with a NSG and a Route Table.