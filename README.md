[![Build status](https://travis-ci.org/alexissavin/ruby-gem-efficientIP.svg)](https://travis-ci.org/alexissavin/ruby-gem-efficientIP)

# EfficientIP SOLIDserver Gem

This Gem allows to easily interact with [SOLIDserver](http://www.efficientip.com/products/solidserver/)'s REST API.
It allows managing all IPAM objects through CRUD operations.

This GEM is compatible with [SOLIDserver](http://www.efficientip.com/products/solidserver/) version 6.0.0 and higher.

It can be easily used within :
* Ruby code - See [rubygems.org](https://rubygems.org/)
* [CHEF](https://www.chef.io/chef/) - See [this blog post](https://blog.chef.io/2009/06/01/cool-chef-tricks-install-and-use-rubygems-in-a-chef-run/)
* [Puppet](https://puppet.com) - See [the puppet documentation](https://docs.puppet.com/puppetserver/latest/gems.html#installing-gems-for-use-with-development)

# Install

Add a dependency in your application's Gemfile :

```
	gem 'SOLIDserver' :git => "git://github.com/efficientip/SOLIDserver.git"

```

Then execute :

```
	$ bundle install
```

Or install it yourself as:

```
	$ gem install SOLIDserver
```

# Usage
## Using the SOLIDserver object
Before making method calls, you need to instance a SOLIDserver object using your credentials.

```
	require "SOLIDserver"

	apiendpoint = SOLIDserver::SOLIDserver.new('<SOLIDserver IP address>', '<login>', '<password>')
```

Once this operation completed, you are able to interact with the IPAM's objects directly using any supported method.

Each method return (except the doc one) retrun a REST object containing a json body and a return code.

```
	puts apiendpoint.ip_address_list(limit: 128).body
```

## Methods Naming Convention
Each available method rely on the following naming convention for intuitive usage :

```
	<module>_<object>_<action>
```

Supported modules are :

* ip (IPAM - IP Address Management)
* vlm (VLAN Manager - VLAN Resources Management)

## Mandatory Parameters
Some methods require specific parameters combination. These parameters are listed in the method list below in the following format :

```
	(<required parameter #1> + (<required parameter #2>) | <required parameter #3>)
```

This means that you need to provide :
```
	<required parameter #1> and <required parameter #2>
```
or
```
	<required parameter #1> and <required parameter #3>
```

This parameters must be provided through a hash :

```
	puts sdsapi.ip_site_list(limit: 128, offset: 0, where: "site_name like '%test%'").body
```

## Filtering the result
Some methods allow to filter their output result using a WHERE parameter.

This clause can be applied on any output field combination using an SQL ANSI style clause.

## Available Methods

This GEM wraps the following SOLIDserver API calls, allowing you to interract with SOLIDserver DDI solution.

### Method - ip_site_add
Description

	This service allows to add an IP address Space.

Mandatory Parameters

	site_name

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* site_description - Space description
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_class_name - Space class name
	* site_class_parameters - Space class parameters
	* site_is_template - Space is a template
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* site_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_site_update
Description

	This service allows to update an IP address Space.

Mandatory Parameters

	(site_id | site_name)

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* site_description - Space description
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_class_name - Space class name
	* site_class_parameters - Space class parameters
	* site_is_template - Space is a template
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* site_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_site_count
Description

	This service returns the number of IP address Spaces matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_site_list
Description

	This service returns a list of IP address Spaces matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* site_is_template - Space is a template
	* site_id - Space ID
	* tree_level
	* tree_path
	* tree_id_path
	* site_is_default
	* site_name - Space name
	* site_description - Space description
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_class_name - Space class name
	* parent_site_class_name
	* row_enabled
	* multistatus
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* site_class_parameters_inheritance_source
	* parent_site_class_parameters
	* parent_site_class_parameters_properties

### Method - ip_site_info
Description

	This service returns information about a specific IP address Space.

Available Input Parameters :

	* site_id

Available Output Fields :

	* site_is_template - Space is a template
	* site_id - Space ID
	* tree_level
	* tree_path
	* tree_id_path
	* site_is_default
	* site_name - Space name
	* site_description - Space description
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_class_name - Space class name
	* parent_site_class_name
	* row_enabled
	* multistatus
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* site_class_parameters_inheritance_source
	* parent_site_class_parameters
	* parent_site_class_parameters_properties

### Method - ip_site_delete
Description

	This service allows to delete a specific IP address Space.

Mandatory Parameters

	(site_id | site_name)

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet_add
Description

	This service allows to add an IPv4 Network of type Subnet or Block.

Mandatory Parameters

	(subnet_addr + (subnet_end_addr | subnet_size | subnet_mask | subnet_prefix) + (site_id | site_name | parent_subnet_id))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* subnet_id - Subnet ID
	* subnet_name - Subnet name
	* subnet_addr - Subnet start IP address
	* subnet_end_addr - Subnet end IP address
	* subnet_size - Subnet size
	* subnet_mask - Subnet mask
	* subnet_prefix - Subnet prefix
	* subnet_level - Subnet level
	* parent_subnet_id - Parent subnet id
	* allow_tree_reparenting - Allow Tree Reparenting
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* subnet_class_name - Subnet class name
	* network_class_parameters - Network class parameters
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties
	* permit_invalid - Permit invalid (not a real subnet/allow overlap)
	* permit_overlap - Permit overlap (obsolete)
	* permit_no_block - Allow creating subnet without block
	* changed_waiting_state - Changed waiting state (internal)
	* is_terminal - Subnet is terminal
	* vlmvlan_id - Subnet VLAN ID
	* enabled - Manage/Unmanage
	* check - Launch service in read only
	* lock_network_broadcast - Lock network and broadcast addresses
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* network_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet_update
Description

	This service allows to update an IPv4 Network of type Subnet or Block.

Mandatory Parameters

	(subnet_id | (subnet_addr + (subnet_end_addr | subnet_size | subnet_mask | subnet_prefix) + (site_id | site_name | parent_subnet_id)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* subnet_id - Subnet ID
	* subnet_name - Subnet name
	* subnet_addr - Subnet start IP address
	* subnet_end_addr - Subnet end IP address
	* subnet_size - Subnet size
	* subnet_mask - Subnet mask
	* subnet_prefix - Subnet prefix
	* subnet_level - Subnet level
	* parent_subnet_id - Parent subnet id
	* allow_tree_reparenting - Allow Tree Reparenting
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* subnet_class_name - Subnet class name
	* network_class_parameters - Network class parameters
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties
	* permit_invalid - Permit invalid (not a real subnet/allow overlap)
	* permit_overlap - Permit overlap (obsolete)
	* permit_no_block - Allow creating subnet without block
	* changed_waiting_state - Changed waiting state (internal)
	* is_terminal - Subnet is terminal
	* vlmvlan_id - Subnet VLAN ID
	* enabled - Manage/Unmanage
	* check - Launch service in read only
	* lock_network_broadcast - Lock network and broadcast addresses
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* network_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet_count
Description

	This service returns the number of IPv4 Networks matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_subnet_list
Description

	This service returns a list of IPv4 Networks matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* type
	* subnet_id - Subnet ID
	* start_ip_addr
	* end_ip_addr
	* subnet_name - Subnet name
	* subnet_size - Subnet size
	* vlsm_block_id
	* vlmvlan_id - Subnet VLAN ID
	* subnet_level - Subnet level
	* subnet_path
	* subnet_class_name - Subnet class name
	* parent_subnet_id - Parent subnet id
	* vlsm_subnet_id
	* row_enabled
	* subnet_is_valid
	* site_id - Space ID
	* waiting_state
	* waiting_status
	* is_terminal - Subnet is terminal
	* subnet_allocated_size
	* subnet_allocated_percent
	* subnet_used_size
	* subnet_used_percent
	* subnet_ip_used_size
	* subnet_ip_used_percent
	* subnet_ip_free_size
	* is_in_orphan
	* lock_network_broadcast - Lock network and broadcast addresses
	* site_description - Space description
	* site_name - Space name
	* site_is_template - Space is a template
	* tree_level
	* tree_path
	* tree_id_path
	* site_class_name - Space class name
	* parent_subnet_name
	* parent_start_ip_addr
	* parent_end_ip_addr
	* parent_subnet_size
	* parent_subnet_level
	* parent_subnet_path
	* parent_subnet_class_name
	* parent_is_terminal
	* parent_vlsm_subnet_id
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_parent_site_id
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* vlmvlan_vlan_id
	* vlmvlan_name
	* vlmdomain_id
	* vlmdomain_name
	* vlmrange_id
	* vlmrange_name
	* multistatus
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties
	* subnet_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* parent_subnet_class_parameters
	* parent_subnet_class_parameters_properties

### Method - ip_subnet_info
Description

	This service returns information about a specific IPv4 Network.

Available Input Parameters :

	* subnet_id

Available Output Fields :

	* type
	* subnet_id - Subnet ID
	* start_ip_addr
	* end_ip_addr
	* subnet_name - Subnet name
	* subnet_size - Subnet size
	* vlsm_block_id
	* vlmvlan_id - Subnet VLAN ID
	* subnet_level - Subnet level
	* subnet_path
	* subnet_class_name - Subnet class name
	* parent_subnet_id - Parent subnet id
	* vlsm_subnet_id
	* row_enabled
	* subnet_is_valid
	* site_id - Space ID
	* waiting_state
	* waiting_status
	* is_terminal - Subnet is terminal
	* subnet_allocated_size
	* subnet_allocated_percent
	* subnet_used_size
	* subnet_used_percent
	* subnet_ip_used_size
	* subnet_ip_used_percent
	* subnet_ip_free_size
	* is_in_orphan
	* lock_network_broadcast - Lock network and broadcast addresses
	* site_description - Space description
	* site_name - Space name
	* site_is_template - Space is a template
	* tree_level
	* tree_path
	* tree_id_path
	* site_class_name - Space class name
	* parent_subnet_name
	* parent_start_ip_addr
	* parent_end_ip_addr
	* parent_subnet_size
	* parent_subnet_level
	* parent_subnet_path
	* parent_subnet_class_name
	* parent_is_terminal
	* parent_vlsm_subnet_id
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_parent_site_id
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* vlmvlan_vlan_id
	* vlmvlan_name
	* vlmdomain_id
	* vlmdomain_name
	* vlmrange_id
	* vlmrange_name
	* multistatus
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties
	* subnet_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* parent_subnet_class_parameters
	* parent_subnet_class_parameters_properties

### Method - ip_subnet_delete
Description

	This service allows to delete a specific IPv4 Network.

Mandatory Parameters

	(subnet_id | (subnet_addr + (subnet_end_addr | subnet_size | subnet_mask | subnet_prefix) + (parent_subnet_id | subnet_level | relative_position) + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* parent_subnet_id - Parent Subnet ID
	* subnet_name - Subnet name
	* subnet_addr - Subnet start IP address
	* subnet_end_addr - Subnet end IP address
	* subnet_size - Subnet size
	* subnet_mask - Subnet mask
	* subnet_prefix - Subnet prefix
	* subnet_level - Subnet level
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet_find_free
Description

	This service allows to retrieve a list of available IPv4 Networks matching optional condition(s).

Available Input Parameters :

	* site_id
	* prefix
	* size
	* reserved_prefix
	* max_find
	* begin_addr
	* end_addr
	* where - Can be used to filter the result using any output field in an SQL fashion.
	* block_id
	* use_searched_path

Available Output Fields :

	* start_ip_addr
	* block_name
	* find_type
	* cost
	* block_id
	* site_id - Space ID

### Method - ip_subnet6_add
Description

	This service allows to add an IPv6 Network of type Subnet or Block.

Mandatory Parameters

	(subnet6_addr + (subnet6_end_addr | subnet6_prefix) + (site_id | site_name | parent_subnet6_id))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* subnet6_id - Subnet6 ID
	* subnet6_name - Subnet6 name
	* subnet6_addr - Subnet6 start IP address
	* subnet6_end_addr - Subnet6 end IP address
	* subnet6_prefix - Subnet6 prefix
	* subnet_level - Subnet level
	* parent_subnet6_id - Parent subnet6 id
	* allow_tree_reparenting - Allow Tree Reparenting
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* subnet6_class_name - Subnet class name
	* network6_class_parameters - Network class parameters
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties
	* permit_invalid - Permit invalid (not a real subnet6/allow overlap)
	* permit_overlap - Permit overlap (obsolete)
	* permit_no_block6 - Allow creating subnet6 without block6
	* changed_waiting_state - Changed waiting state (internal)
	* is_terminal - Subnet is terminal
	* vlmvlan_id - Subnet VLAN ID
	* enabled - Manage/Unmanage
	* check - Launch service in read only
	* lock_network_broadcast - Lock network and broadcast addresses
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* network6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet6_update
Description

	This service allows to update an IPv6 Network of type Subnet or Block.

Mandatory Parameters

	(subnet6_id | (subnet6_addr + (subnet6_end_addr | subnet6_prefix) + (site_id | site_name | parent_subnet6_id)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* subnet6_id - Subnet6 ID
	* subnet6_name - Subnet6 name
	* subnet6_addr - Subnet6 start IP address
	* subnet6_end_addr - Subnet6 end IP address
	* subnet6_prefix - Subnet6 prefix
	* subnet_level - Subnet level
	* parent_subnet6_id - Parent subnet6 id
	* allow_tree_reparenting - Allow Tree Reparenting
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* subnet6_class_name - Subnet class name
	* network6_class_parameters - Network class parameters
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties
	* permit_invalid - Permit invalid (not a real subnet6/allow overlap)
	* permit_overlap - Permit overlap (obsolete)
	* permit_no_block6 - Allow creating subnet6 without block6
	* changed_waiting_state - Changed waiting state (internal)
	* is_terminal - Subnet is terminal
	* vlmvlan_id - Subnet VLAN ID
	* enabled - Manage/Unmanage
	* check - Launch service in read only
	* lock_network_broadcast - Lock network and broadcast addresses
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* network6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet6_count
Description

	This service returns the number of IPv6 Networks matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_subnet6_list
Description

	This service returns a list of IPv6 Networks matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* type
	* subnet6_id - Subnet6 ID
	* start_ip6_addr
	* end_ip6_addr
	* subnet6_name - Subnet6 name
	* subnet_size - Subnet size
	* vlsm_block6_id
	* vlmvlan_id - Subnet VLAN ID
	* subnet_level - Subnet level
	* subnet_path
	* subnet6_class_name - Subnet class name
	* parent_subnet6_id - Parent subnet6 id
	* vlsm_subnet6_id
	* row_enabled
	* subnet6_is_valid
	* lock_network_broadcast - Lock network and broadcast addresses
	* site_id - Space ID
	* waiting_state
	* waiting_status
	* is_terminal - Subnet is terminal
	* subnet6_prefix - Subnet6 prefix
	* percent_allocated
	* percent_used
	* is_in_orphan
	* site_description - Space description
	* site_name - Space name
	* site_is_template - Space is a template
	* tree_level
	* tree_path
	* tree_id_path
	* site_class_name - Space class name
	* parent_subnet6_name
	* parent_start_ip6_addr
	* parent_end_ip6_addr
	* parent_subnet_size
	* parent_subnet_level
	* parent_subnet_path
	* parent_subnet6_class_name
	* parent_is_terminal
	* parent_vlsm_subnet6_id
	* parent_subnet6_prefix
	* parent_percent_allocated
	* parent_percent_used
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_parent_site_id
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* vlmvlan_vlan_id
	* vlmvlan_name
	* vlmdomain_id
	* vlmdomain_name
	* vlmrange_id
	* vlmrange_name
	* multistatus
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties
	* subnet6_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* parent_subnet6_class_parameters
	* parent_subnet6_class_parameters_properties

### Method - ip_subnet6_info
Description

	This service returns information about a specific IPv6 Network.

Available Input Parameters :

	* subnet6_id

Available Output Fields :

	* type
	* subnet6_id - Subnet6 ID
	* start_ip6_addr
	* end_ip6_addr
	* subnet6_name - Subnet6 name
	* subnet_size - Subnet size
	* vlsm_block6_id
	* vlmvlan_id - Subnet VLAN ID
	* subnet_level - Subnet level
	* subnet_path
	* subnet6_class_name - Subnet class name
	* parent_subnet6_id - Parent subnet6 id
	* vlsm_subnet6_id
	* row_enabled
	* subnet6_is_valid
	* lock_network_broadcast - Lock network and broadcast addresses
	* site_id - Space ID
	* waiting_state
	* waiting_status
	* is_terminal - Subnet is terminal
	* subnet6_prefix - Subnet6 prefix
	* percent_allocated
	* percent_used
	* is_in_orphan
	* site_description - Space description
	* site_name - Space name
	* site_is_template - Space is a template
	* tree_level
	* tree_path
	* tree_id_path
	* site_class_name - Space class name
	* parent_subnet6_name
	* parent_start_ip6_addr
	* parent_end_ip6_addr
	* parent_subnet_size
	* parent_subnet_level
	* parent_subnet_path
	* parent_subnet6_class_name
	* parent_is_terminal
	* parent_vlsm_subnet6_id
	* parent_subnet6_prefix
	* parent_percent_allocated
	* parent_percent_used
	* parent_site_id - Space parent ID
	* parent_site_name - Space parent name
	* site_parent_site_id
	* vlsm_site_id - VLSM space ID
	* vlsm_site_name - VLSM space name
	* vlmvlan_vlan_id
	* vlmvlan_name
	* vlmdomain_id
	* vlmdomain_name
	* vlmrange_id
	* vlmrange_name
	* multistatus
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties
	* subnet6_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* parent_subnet6_class_parameters
	* parent_subnet6_class_parameters_properties

### Method - ip_subnet6_delete
Description

	This service allows to delete a specific IPv6 Network.

Mandatory Parameters

	(subnet6_id | (subnet6_addr + (subnet6_end_addr | subnet6_prefix) + (parent_subnet6_id | subnet_level | relative_position) + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet6_id - Subnet6 ID
	* parent_subnet6_id - Parent Subnet6 ID
	* subnet6_name - Subnet6 name
	* subnet6_addr - Subnet6 start IP address
	* subnet6_end_addr - Subnet6 end IP address
	* subnet6_prefix - Subnet6 prefix
	* subnet_level - Subnet level
	* relative_position - Relative position to a space
	* use_reversed_relative_position - Use the reversed relative position (start by the end)
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_subnet6_find_free
Description

	This service allows to retrieve a list of available IPv6 Networks matching optional condition(s).

Available Input Parameters :

	* site_id
	* prefix
	* reserved_prefix
	* max_find
	* begin_addr
	* end_addr
	* where - Can be used to filter the result using any output field in an SQL fashion.
	* block6_id
	* use_searched_path

Available Output Fields :

	* start_ip6_addr
	* block6_name
	* find_type
	* cost
	* block6_id
	* site_id - Space ID

### Method - ip_pool_add
Description

	This service allows to add an IPv4 Address Pool.

Mandatory Parameters

	(start_addr + (end_addr | pool_size) + (subnet_id | site_id | site_name))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* pool_id - Pool ID
	* pool_name - Pool name
	* start_addr - Pool start IP address
	* end_addr - Pool end IP address
	* pool_size - Pool size
	* pool_class_name - Pool class name
	* pool_class_parameters - Pool class parameters
	* pool_read_only - Pool is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* pool_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_pool_update
Description

	This service allows to update an IPv4 Address Pool.

Mandatory Parameters

	(pool_id | (start_addr + (end_addr | pool_size) + (subnet_id | site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* pool_id - Pool ID
	* pool_name - Pool name
	* start_addr - Pool start IP address
	* end_addr - Pool end IP address
	* pool_size - Pool size
	* pool_class_name - Pool class name
	* pool_class_parameters - Pool class parameters
	* pool_read_only - Pool is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* pool_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_pool_count
Description

	This service returns the number of IPv4 Address Pools matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_pool_list
Description

	This service returns a list of IPv4 Address Pools matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* site_name - Space name
	* site_id - Space ID
	* site_description - Space description
	* site_class_name - Space class name
	* site_is_template - Space is a template
	* tree_path
	* pool_id - Pool ID
	* pool_name - Pool name
	* pool_class_name - Pool class name
	* pool_read_only - Pool is in read only mode
	* start_ip_addr
	* end_ip_addr
	* pool_start_ip_addr
	* pool_end_ip_addr
	* pool_size - Pool size
	* parent_subnet_name
	* parent_subnet_id - Parent Subnet ID
	* parent_subnet_size
	* vlsm_subnet_id
	* parent_subnet_class_name
	* subnet_name - Subnet name
	* vlsm_block_id
	* subnet_id - Subnet ID
	* subnet_start_ip_addr
	* subnet_end_ip_addr
	* subnet_size - Subnet size
	* subnet_class_name - Subnet class name
	* multistatus
	* pool_class_parameters - Pool class parameters
	* pool_class_parameters_properties - Class parameters properties
	* pool_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties

### Method - ip_pool_info
Description

	This service returns information about a specific IPv4 Address Pool.

Available Input Parameters :

	* pool_id

Available Output Fields :

	* site_name - Space name
	* site_id - Space ID
	* site_description - Space description
	* site_class_name - Space class name
	* site_is_template - Space is a template
	* tree_path
	* pool_id - Pool ID
	* pool_name - Pool name
	* pool_class_name - Pool class name
	* pool_read_only - Pool is in read only mode
	* start_ip_addr
	* end_ip_addr
	* pool_start_ip_addr
	* pool_end_ip_addr
	* pool_size - Pool size
	* parent_subnet_name
	* parent_subnet_id - Parent Subnet ID
	* parent_subnet_size
	* vlsm_subnet_id
	* parent_subnet_class_name
	* subnet_name - Subnet name
	* vlsm_block_id
	* subnet_id - Subnet ID
	* subnet_start_ip_addr
	* subnet_end_ip_addr
	* subnet_size - Subnet size
	* subnet_class_name - Subnet class name
	* multistatus
	* pool_class_parameters - Pool class parameters
	* pool_class_parameters_properties - Class parameters properties
	* pool_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties

### Method - ip_pool_delete
Description

	This service allows to delete a specific IPv4 Address Pool.

Mandatory Parameters

	(pool_id | (start_addr + (end_addr | pool_size) + (subnet_id | site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* pool_id - Pool ID
	* start_addr - Pool start IP address
	* end_addr - Pool end IP address
	* pool_size - Pool size
	* pool_class_name - Pool class name
	* pool_class_parameters - Pool class parameters
	* pool_read_only - Pool is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_pool6_add
Description

	This service allows to add an IPv6 Address Pool.

Mandatory Parameters

	(start_addr + end_addr + (subnet6_id | site_id | site_name))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet6_id - Subnet6 ID
	* pool6_id - Pool6 ID
	* pool6_name - Pool6 name
	* start_addr - Pool6 start IP address
	* end_addr - Pool6 end IP address
	* pool6_class_name - Pool6 class name
	* pool6_class_parameters - Pool6 class parameters
	* pool6_read_only - Pool6 is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* pool6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_pool6_update
Description

	This service allows to update an IPv6 Address Pool.

Mandatory Parameters

	(pool6_id | (start_addr + end_addr + (subnet6_id | site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet6_id - Subnet6 ID
	* pool6_id - Pool6 ID
	* pool6_name - Pool6 name
	* start_addr - Pool6 start IP address
	* end_addr - Pool6 end IP address
	* pool6_class_name - Pool6 class name
	* pool6_class_parameters - Pool6 class parameters
	* pool6_read_only - Pool6 is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* pool6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_pool6_count
Description

	This service returns the number of IPv6 Address Pools matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_pool6_list
Description

	This service returns a list of IPv6 Address Pools matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* site_name - Space name
	* site_id - Space ID
	* site_description - Space description
	* site_class_name - Space class name
	* site_is_template - Space is a template
	* tree_path
	* pool6_id - Pool6 ID
	* pool6_name - Pool6 name
	* pool6_class_name - Pool6 class name
	* pool6_read_only - Pool6 is in read only mode
	* start_ip6_addr
	* end_ip6_addr
	* pool6_start_ip6_addr
	* pool6_end_ip6_addr
	* pool6_size
	* parent_subnet6_name
	* parent_subnet6_id - Parent Subnet6 ID
	* vlsm_subnet6_id
	* parent_subnet6_prefix
	* parent_subnet6_class_name
	* subnet6_name - Subnet6 name
	* vlsm_block6_id
	* subnet6_id - Subnet6 ID
	* subnet6_start_ip6_addr
	* subnet6_end_ip6_addr
	* subnet6_class_name - Subnet class name
	* subnet6_prefix - Subnet6 prefix
	* multistatus
	* pool6_class_parameters - Pool6 class parameters
	* pool6_class_parameters_properties - Class parameters properties
	* pool6_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties

### Method - ip_pool6_info
Description

	This service returns information about a specific IPv6 Address Pool.

Available Input Parameters :

	* pool6_id

Available Output Fields :

	* site_name - Space name
	* site_id - Space ID
	* site_description - Space description
	* site_class_name - Space class name
	* site_is_template - Space is a template
	* tree_path
	* pool6_id - Pool6 ID
	* pool6_name - Pool6 name
	* pool6_class_name - Pool6 class name
	* pool6_read_only - Pool6 is in read only mode
	* start_ip6_addr
	* end_ip6_addr
	* pool6_start_ip6_addr
	* pool6_end_ip6_addr
	* pool6_size
	* parent_subnet6_name
	* parent_subnet6_id - Parent Subnet6 ID
	* vlsm_subnet6_id
	* parent_subnet6_prefix
	* parent_subnet6_class_name
	* subnet6_name - Subnet6 name
	* vlsm_block6_id
	* subnet6_id - Subnet6 ID
	* subnet6_start_ip6_addr
	* subnet6_end_ip6_addr
	* subnet6_class_name - Subnet class name
	* subnet6_prefix - Subnet6 prefix
	* multistatus
	* pool6_class_parameters - Pool6 class parameters
	* pool6_class_parameters_properties - Class parameters properties
	* pool6_class_parameters_inheritance_source
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties

### Method - ip_pool6_delete
Description

	This service allows to delete a specific IPv6 Address Pool.

Mandatory Parameters

	(pool6_id | (start_addr + end_addr + (subnet6_id | site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* subnet6_id - Subnet6 ID
	* pool6_id - Pool6 ID
	* start_addr - Pool6 start IP address
	* end_addr - Pool6 end IP address
	* pool6_class_name - Pool6 class name
	* pool6_class_parameters - Pool6 class parameters
	* pool6_read_only - Pool6 is in read only mode
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address_add
Description

	This service allows to add an IPv4 Address.

Mandatory Parameters

	(hostaddr + (site_id | site_name))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip_id - IP address ID
	* name - IP address name
	* ip_name - IP address name
	* mac_addr - IP address MAC address
	* ip_addr - IP address
	* hostaddr - IP address
	* ip_class_name - IP address class name
	* ip_class_parameters - IP address class parameters
	* hostdev_id - Device ID
	* hostiface_id - Interface ID
	* iplport_id - NetChange port ID
	* last_info - Information about the last call of the service
	* dhcphost_id - DHCP Static ID
	* dhcplease_id - DHCP Lease ID
	* check - Launch service in read only
	* check_is_dhcp_ip - Check if the IP is valid for DHCP
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* ip_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address_update
Description

	This service allows to update an IPv4 Address.

Mandatory Parameters

	(ip_id | (hostaddr + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip_id - IP address ID
	* name - IP address name
	* ip_name - IP address name
	* mac_addr - IP address MAC address
	* ip_addr - IP address
	* hostaddr - IP address
	* ip_class_name - IP address class name
	* ip_class_parameters - IP address class parameters
	* hostdev_id - Device ID
	* hostiface_id - Interface ID
	* iplport_id - NetChange port ID
	* last_info - Information about the last call of the service
	* dhcphost_id - DHCP Static ID
	* dhcplease_id - DHCP Lease ID
	* check - Launch service in read only
	* check_is_dhcp_ip - Check if the IP is valid for DHCP
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* ip_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address_count
Description

	This service returns the number of IPv4 Addresses matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_address_list
Description

	This service returns a list of IPv4 Addresses matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* type
	* free_start_ip_addr
	* free_end_ip_addr
	* free_scope_size
	* ip_id - IP address ID
	* site_is_template - Space is a template
	* site_name - Space name
	* tree_level
	* tree_path
	* tree_id_path
	* ip_addr - IP address
	* name - IP address name
	* mac_addr - IP address MAC address
	* ip_class_name - IP address class name
	* parent_subnet_id - Parent Subnet ID
	* parent_subnet_name
	* parent_subnet_size
	* parent_vlsm_subnet_id
	* parent_subnet_class_name
	* parent_subnet_start_ip_addr
	* parent_subnet_end_ip_addr
	* subnet_name - Subnet name
	* pool_name - Pool name
	* site_id - Space ID
	* subnet_id - Subnet ID
	* subnet_start_ip_addr
	* subnet_end_ip_addr
	* subnet_size - Subnet size
	* subnet_is_terminal
	* lock_network_broadcast - Lock network and broadcast addresses
	* pool_class_name - Pool class name
	* pool_id - Pool ID
	* pool_read_only - Pool is in read only mode
	* pool_row_enabled
	* iplnetdev_name
	* iplnetdev_id
	* iplport_name
	* iplport_slotnumber
	* iplport_portnumber
	* iplport_ifvlan
	* hostiface_name
	* hostiface_id - Interface ID
	* hostdev_name
	* hostdev_id - Device ID
	* dhcphost_id - DHCP Static ID
	* dhcplease_id - DHCP Lease ID
	* last_seen
	* dhcplease_end_time
	* site_description - Space description
	* site_class_name - Space class name
	* subnet_class_name - Subnet class name
	* pool_size - Pool size
	* pool_start_ip_addr
	* pool_end_ip_addr
	* ip_alias
	* multistatus
	* tag_pool_dhcprange
	* ip_class_parameters - IP address class parameters
	* ip_class_parameters_properties - Class parameters properties
	* ip_class_parameters_inheritance_source
	* pool_class_parameters - Pool class parameters
	* pool_class_parameters_properties - Class parameters properties
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties

### Method - ip_address_info
Description

	This service returns information about a specific IPv4 Address.

Available Input Parameters :

	* ip_id

Available Output Fields :

	* type
	* free_start_ip_addr
	* free_end_ip_addr
	* free_scope_size
	* ip_id - IP address ID
	* site_is_template - Space is a template
	* site_name - Space name
	* tree_level
	* tree_path
	* tree_id_path
	* ip_addr - IP address
	* name - IP address name
	* mac_addr - IP address MAC address
	* ip_class_name - IP address class name
	* parent_subnet_id - Parent Subnet ID
	* parent_subnet_name
	* parent_subnet_size
	* parent_vlsm_subnet_id
	* parent_subnet_class_name
	* parent_subnet_start_ip_addr
	* parent_subnet_end_ip_addr
	* subnet_name - Subnet name
	* pool_name - Pool name
	* site_id - Space ID
	* subnet_id - Subnet ID
	* subnet_start_ip_addr
	* subnet_end_ip_addr
	* subnet_size - Subnet size
	* subnet_is_terminal
	* lock_network_broadcast - Lock network and broadcast addresses
	* pool_class_name - Pool class name
	* pool_id - Pool ID
	* pool_read_only - Pool is in read only mode
	* pool_row_enabled
	* iplnetdev_name
	* iplnetdev_id
	* iplport_name
	* iplport_slotnumber
	* iplport_portnumber
	* iplport_ifvlan
	* hostiface_name
	* hostiface_id - Interface ID
	* hostdev_name
	* hostdev_id - Device ID
	* dhcphost_id - DHCP Static ID
	* dhcplease_id - DHCP Lease ID
	* last_seen
	* dhcplease_end_time
	* site_description - Space description
	* site_class_name - Space class name
	* subnet_class_name - Subnet class name
	* pool_size - Pool size
	* pool_start_ip_addr
	* pool_end_ip_addr
	* ip_alias
	* multistatus
	* tag_pool_dhcprange
	* ip_class_parameters - IP address class parameters
	* ip_class_parameters_properties - Class parameters properties
	* ip_class_parameters_inheritance_source
	* pool_class_parameters - Pool class parameters
	* pool_class_parameters_properties - Class parameters properties
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet_class_parameters - Subnet class parameters
	* subnet_class_parameters_properties - Subnet class parameters properties

### Method - ip_address_delete
Description

	This service allows to delete a specific IPv4 Address.

Mandatory Parameters

	(ip_id | (hostaddr + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip_id - IP address ID
	* name - IP address name
	* ip_name - IP address name
	* ip_addr - IP address
	* hostaddr - IP address
	* ip_class_name - IP address class name
	* ip_class_parameters - IP address class parameters
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address_find_free
Description

	This service allows to retrieve a list of available IPv4 Addresses matching optional condition(s).

Available Input Parameters :

	* subnet_id
	* parent_subnet_id
	* pool_id
	* max_find
	* where - Can be used to filter the result using any output field in an SQL fashion.
	* begin_addr
	* end_addr
	* pool_class_name
	* subnet_class_name

Available Output Fields :

	* ip_addr - IP address
	* hostaddr - IP address
	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* subnet_name - Subnet name
	* pool_id - Pool ID
	* pool_name - Pool name

### Method - ip_address6_add
Description

	This service allows to add an IPv6 Address

Mandatory Parameters

	(hostaddr + (site_id | site_name))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip6_id - IP6 address ID
	* ip6_name - IP6 address name
	* ip6_mac_addr - IP6 address MAC address
	* ip6_addr - IP6 address
	* hostaddr - IP6 address
	* ip6_class_name - IP6 address class name
	* ip6_class_parameters - IP6 address class parameters
	* last_info - Information about the last call of the service
	* hostdev_id - Device ID
	* hostiface_id - Interface ID
	* iplport_id - NetChange port ID
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* ip6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address6_update
Description

	This service allows to update an IPv6 Address

Mandatory Parameters

	(ip6_id | (hostaddr + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip6_id - IP6 address ID
	* ip6_name - IP6 address name
	* ip6_mac_addr - IP6 address MAC address
	* ip6_addr - IP6 address
	* hostaddr - IP6 address
	* ip6_class_name - IP6 address class name
	* ip6_class_parameters - IP6 address class parameters
	* last_info - Information about the last call of the service
	* hostdev_id - Device ID
	* hostiface_id - Interface ID
	* iplport_id - NetChange port ID
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* ip6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address6_count
Description

	This service returns the number of IPv6 Addresses matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - ip_address6_list
Description

	This service returns a list of IPv6 Addresses matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* type
	* free_start_ip6_addr
	* free_end_ip6_addr
	* free_scope_size
	* ip6_id - IP6 address ID
	* site_name - Space name
	* tree_level
	* tree_path
	* parent_subnet6_name
	* ip6_addr - IP6 address
	* ip6_name - IP6 address name
	* ip6_mac_addr - IP6 address MAC address
	* ip6_class_name - IP6 address class name
	* subnet6_name - Subnet6 name
	* subnet6_is_terminal
	* lock_network_broadcast - Lock network and broadcast addresses
	* pool6_name - Pool6 name
	* site_id - Space ID
	* subnet6_id - Subnet6 ID
	* subnet6_start_ip6_addr
	* subnet6_end_ip6_addr
	* subnet6_size
	* subnet_size - Subnet size
	* subnet6_prefix - Subnet6 prefix
	* parent_subnet6_size
	* parent_subnet6_id - Parent Subnet6 ID
	* parent_vlsm_subnet6_id
	* pool6_class_name - Pool6 class name
	* pool6_id - Pool6 ID
	* pool6_read_only - Pool6 is in read only mode
	* pool6_row_enabled
	* hostiface_name
	* hostiface_id - Interface ID
	* hostdev_name
	* hostdev_id - Device ID
	* site_description - Space description
	* site_class_name - Space class name
	* row_enabled
	* parent_site_name - Space parent name
	* parent_subnet6_class_name
	* parent_subnet6_prefix
	* parent_subnet6_start_ip6_addr
	* parent_subnet6_end_ip6_addr
	* vlsm_subnet6_id
	* subnet6_class_name - Subnet class name
	* pool6_size
	* pool6_start_ip6_addr
	* pool6_end_ip6_addr
	* ip6_alias
	* ip6_class_parameters - IP6 address class parameters
	* ip6_class_parameters_properties - Class parameters properties
	* ip6_class_parameters_inheritance_source
	* pool6_class_parameters - Pool6 class parameters
	* pool6_class_parameters_properties - Class parameters properties
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties

### Method - ip_address6_info
Description

	This service returns information about a specific IPv6 Address.

Available Input Parameters :

	* ip6_id

Available Output Fields :

	* type
	* free_start_ip6_addr
	* free_end_ip6_addr
	* free_scope_size
	* ip6_id - IP6 address ID
	* site_name - Space name
	* tree_level
	* tree_path
	* parent_subnet6_name
	* ip6_addr - IP6 address
	* ip6_name - IP6 address name
	* ip6_mac_addr - IP6 address MAC address
	* ip6_class_name - IP6 address class name
	* subnet6_name - Subnet6 name
	* subnet6_is_terminal
	* lock_network_broadcast - Lock network and broadcast addresses
	* pool6_name - Pool6 name
	* site_id - Space ID
	* subnet6_id - Subnet6 ID
	* subnet6_start_ip6_addr
	* subnet6_end_ip6_addr
	* subnet6_size
	* subnet_size - Subnet size
	* subnet6_prefix - Subnet6 prefix
	* parent_subnet6_size
	* parent_subnet6_id - Parent Subnet6 ID
	* parent_vlsm_subnet6_id
	* pool6_class_name - Pool6 class name
	* pool6_id - Pool6 ID
	* pool6_read_only - Pool6 is in read only mode
	* pool6_row_enabled
	* hostiface_name
	* hostiface_id - Interface ID
	* hostdev_name
	* hostdev_id - Device ID
	* site_description - Space description
	* site_class_name - Space class name
	* row_enabled
	* parent_site_name - Space parent name
	* parent_subnet6_class_name
	* parent_subnet6_prefix
	* parent_subnet6_start_ip6_addr
	* parent_subnet6_end_ip6_addr
	* vlsm_subnet6_id
	* subnet6_class_name - Subnet class name
	* pool6_size
	* pool6_start_ip6_addr
	* pool6_end_ip6_addr
	* ip6_alias
	* ip6_class_parameters - IP6 address class parameters
	* ip6_class_parameters_properties - Class parameters properties
	* ip6_class_parameters_inheritance_source
	* pool6_class_parameters - Pool6 class parameters
	* pool6_class_parameters_properties - Class parameters properties
	* site_class_parameters - Space class parameters
	* site_class_parameters_properties - Class parameters properties
	* subnet6_class_parameters - Subnet class parameters
	* subnet6_class_parameters_properties - Subnet class parameters properties

### Method - ip_address6_delete
Description

	This service allows to delete a specific IPv6 Address.

Mandatory Parameters

	(ip6_id | (hostaddr + (site_id | site_name)))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip6_id - IP6 address ID
	* ip6_name - IP6 address name
	* ip6_addr - IP6 address
	* hostaddr - IP address
	* ip6_class_name - IP6 address class name
	* ip6_class_parameters - IP6 address class parameters
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* ip6_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_address6_find_free
Description

	This service allows to retrieve a list of available IPv6 Addresses matching optional condition(s).

Available Input Parameters :

	* subnet6_id
	* parent_subnet6_id
	* pool6_id
	* max_find
	* where - Can be used to filter the result using any output field in an SQL fashion.
	* begin_addr
	* end_addr
	* pool6_class_name
	* subnet6_class_name

Available Output Fields :

	* ip6_addr - IP6 address
	* hostaddr6
	* site_id - Space ID
	* site_name - Space name
	* subnet_id - Subnet ID
	* subnet6_name - Subnet6 name
	* pool6_id - Pool6 ID
	* pool6_name - Pool6 name

### Method - ip_alias_add
Description

	This service allows to associate an Alias of type A or CNAME to an IPv4 Address.

Mandatory Parameters

	(ip_name + (ip_id | (hostaddr + (site_id | site_name))))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip_id - IP address ID
	* ip_name_id - IP address alias ID
	* ip_name - IP address alias
	* name - IP address alias
	* ip_name_type - IP name type
	* ip_addr - IP address
	* hostaddr - IP address
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_alias_list
Description

	This service returns the list of an IPv4 Address' associated Aliases.

Available Input Parameters :

	* ip_id
	* orderby - Can be used to order the result using any output field in an SQL fashion.

### Method - ip_alias_delete
Description

	This service allows to remove an Alias associated to an IPv4 Address.

Mandatory Parameters

	(ip_name_id | (ip_name + (ip_id | (hostaddr + (site_id | site_name)))))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip_id - IP address ID
	* ip_name_id - IP address alias ID
	* ip_name - IP address alias
	* ip_name_type - IP name type
	* ip_addr - IP address
	* hostaddr - IP address
	* old_ip - Old IP address name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_alias6_add
Description

	This service allows to associate an Alias of type A or CNAME to an IPv4 Address.

Mandatory Parameters

	(ip6_name + (ip6_id | (hostaddr + (site_id | site_name))))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip6_id - IP6 address ID
	* ip6_name_id - IP6 address alias ID
	* ip6_name - IP6 address alias
	* name - IP6 address alias
	* ip6_name_type - IP name type
	* ip6_addr - IP6 address
	* hostaddr - IP6 address
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - ip_alias6_list
Description

	This service returns the list of an IPv6 Address' associated Aliases.

Available Input Parameters :

	* ip6_id
	* orderby - Can be used to order the result using any output field in an SQL fashion.

### Method - ip_alias6_delete
Description

	This service allows to remove an Alias associated to an IPv6 Address.

Mandatory Parameters

	(ip6_name_id | (ip6_name + (ip6_id | (hostaddr + (site_id | site_name)))))

Available Input Parameters :

	* site_id - Space ID
	* site_name - Space name
	* ip6_id - IP6 address ID
	* ip6_name_id - IP6 address alias ID
	* ip6_name - IP6 address alias
	* ip6_name_type - IP name type
	* ip6_addr - IP6 address
	* hostaddr - IP6 address
	* old_ip6 - Old IP address name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_domain_add
Description

	This service allows to add a VLAN Domain.

Mandatory Parameters

	vlmdomain_name

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_description - VLAN Domain description
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* vlmdomain_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_domain_update
Description

	This service allows to update a VLAN Domain.

Mandatory Parameters

	(vlmdomain_id | vlmdomain_name)

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_description - VLAN Domain description
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* vlmdomain_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_domain_count
Description

	This service returns the number of VLAN Domains matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - vlm_domain_list
Description

	This service returns a list of VLAN Domains matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_description - VLAN Domain description
	* vlmdomain_class_name - VLAN Domain class name
	* row_enabled
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* vlmdomain_class_parameters_properties - Class parameters properties
	* vlmdomain_class_parameters_inheritance_source

### Method - vlm_domain_info
Description

	This service returns information about a specific VLAN Domain.

Available Input Parameters :

	* vlmdomain_id

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_description - VLAN Domain description
	* vlmdomain_class_name - VLAN Domain class name
	* row_enabled
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* vlmdomain_class_parameters_properties - Class parameters properties
	* vlmdomain_class_parameters_inheritance_source

### Method - vlm_domain_delete
Description

	This service allows to delete a specific VLAN Domain.

Mandatory Parameters

	(vlmdomain_id | vlmdomain_name)

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_range_add
Description

	This service allows to add a VLAN Range.

Mandatory Parameters

	(vlmrange_name + (vlmdomain_id | vlmdomain_name))

Available Input Parameters :

	* vlmrange_id - VLAN Range ID
	* vlmrange_name - VLAN Range name
	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_description - VLAN Range description
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_disable_overlapping - VLAN Range disable overlapping
	* vlmrange_class_name - VLAN Range class name
	* vlmrange_class_parameters - VLAN Range class parameters
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* vlmrange_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_range_update
Description

	This service allows to update a VLAN Range.

Mandatory Parameters

	(vlmrange_id | (vlmrange_name + (vlmdomain_id | vlmdomain_name)))

Available Input Parameters :

	* vlmrange_id - VLAN Range ID
	* vlmrange_name - VLAN Range name
	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_description - VLAN Range description
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_disable_overlapping - VLAN Range disable overlapping
	* vlmrange_class_name - VLAN Range class name
	* vlmrange_class_parameters - VLAN Range class parameters
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* class_parameters_to_delete - Class parameters to delete
	* vlmrange_class_parameters_properties - Class parameters properties
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_range_count
Description

	This service returns the number of VLAN Ranges matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - vlm_range_list
Description

	This service returns a list of VLAN Domains matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmrange_id - VLAN Range ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_description - VLAN Domain description
	* vlmrange_name - VLAN Range name
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_description - VLAN Range description
	* vlmrange_disable_overlapping - VLAN Range disable overlapping
	* vlmrange_class_name - VLAN Range class name
	* row_enabled
	* vlmrange_class_parameters - VLAN Range class parameters
	* vlmrange_class_parameters_properties - Class parameters properties
	* vlmrange_class_parameters_inheritance_source
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* vlmdomain_class_parameters_properties - Class parameters properties

### Method - vlm_range_info
Description

	This service returns information about a specific VLAN Range.

Available Input Parameters :

	* vlmrange_id

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmrange_id - VLAN Range ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_description - VLAN Domain description
	* vlmrange_name - VLAN Range name
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_description - VLAN Range description
	* vlmrange_disable_overlapping - VLAN Range disable overlapping
	* vlmrange_class_name - VLAN Range class name
	* row_enabled
	* vlmrange_class_parameters - VLAN Range class parameters
	* vlmrange_class_parameters_properties - Class parameters properties
	* vlmrange_class_parameters_inheritance_source
	* vlmdomain_class_parameters - VLAN Domain class parameters
	* vlmdomain_class_parameters_properties - Class parameters properties

### Method - vlm_range_delete
Description

	This service allows to delete a specific VLAN Range.

Mandatory Parameters

	(vlmrange_id | (vlmrange_name + (vlmdomain_id | vlmdomain_name)))

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_id - VLAN range ID
	* vlmrange_name - VLAN range name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_vlan_add
Description

	This service allows to add a VLAN.

Mandatory Parameters

	(vlmvlan_vlan_id + (vlmdomain_id | vlmdomain_name))

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_id - VLAN Range ID
	* vlmrange_name - VLAN Range name
	* vlmvlan_id - VLAN ID
	* vlmvlan_vlan_id - VLAN vlan id
	* vlmvlan_name - VLAN name
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_vlan_update
Description

	This service allows to update a VLAN.

Mandatory Parameters

	(vlmvlan_id | (vlmvlan_vlan_id + (vlmdomain_id | vlmdomain_name)))

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_id - VLAN Range ID
	* vlmrange_name - VLAN Range name
	* vlmvlan_id - VLAN ID
	* vlmvlan_vlan_id - VLAN vlan id
	* vlmvlan_name - VLAN name
	* keep_previous_param - Params to not overwrite for update
	* add_flag - new_edit/new_only/edit_only flag
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

### Method - vlm_vlan_count
Description

	This service returns the number of VLANs matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.

Available Output Fields :

	* total

### Method - vlm_vlan_list
Description

	This service returns a list of VLANs matching optional condition(s).

Available Input Parameters :

	* where - Can be used to filter the result using any output field in an SQL fashion.
	* orderby - Can be used to order the result using any output field in an SQL fashion.
	* offset
	* limit

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_description - VLAN Domain description
	* vlmrange_name - VLAN Range name
	* vlmrange_id - VLAN Range ID
	* vlmrange_row_enabled
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_class_name - VLAN Range class name
	* vlmrange_description - VLAN Range description
	* vlmvlan_id - VLAN ID
	* vlmvlan_name - VLAN name
	* vlmvlan_vlan_id - VLAN vlan id
	* row_enabled

### Method - vlm_vlan_info
Description

	This service returns information about a specific VLAN.

Available Input Parameters :

	* vlmvlan_id

Available Output Fields :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmdomain_start_vlan_id - VLAN Domain start VLAN ID
	* vlmdomain_end_vlan_id - VLAN Domain end VLAN ID
	* vlmdomain_class_name - VLAN Domain class name
	* vlmdomain_description - VLAN Domain description
	* vlmrange_name - VLAN Range name
	* vlmrange_id - VLAN Range ID
	* vlmrange_row_enabled
	* vlmrange_start_vlan_id - VLAN Range start VLAN ID
	* vlmrange_end_vlan_id - VLAN Range end VLAN ID
	* vlmrange_class_name - VLAN Range class name
	* vlmrange_description - VLAN Range description
	* vlmvlan_id - VLAN ID
	* vlmvlan_name - VLAN name
	* vlmvlan_vlan_id - VLAN vlan id
	* row_enabled

### Method - vlm_vlan_delete
Description

	This service allows to delete a specific VLAN.

Mandatory Parameters

	(vlmvlan_id | (vlmvlan_vlan_id + (vlmrange_id | vlmrange_name) + (vlmdomain_id | vlmdomain_name)))

Available Input Parameters :

	* vlmdomain_id - VLAN Domain ID
	* vlmdomain_name - VLAN Domain name
	* vlmrange_id - VLAN Range ID
	* vlmrange_name - VLAN Range name
	* vlmvlan_id - VLAN ID
	* vlmvlan_vlan_id - VLAN vlan id
	* vlmvlan_name - VLAN name
	* keep_previous_param - Params to not overwrite for update
	* no_rule_exec - Dont execute rules
	* only_rule_exec - Only execute rules
	* additional_parameters - Additional parameters passed to rules

Available Output Fields :

	* errno - ID of the error
	* errmsg - Error message
	* msg - Message, information about service
	* severity - severity of the error
	* parameters - Missing parameters
	* param_format - format of the incorrect parameter
	* param_value - value of the incorrect parameter
	* param_name - name of the incorrect parameter
	* ret_oid - Return oid

