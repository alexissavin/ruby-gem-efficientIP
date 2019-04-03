require 'rest-client'
require 'base64'
require 'json'
require 'erb'

# Extend Net::HTTPHeader to comply with case sensitive headers
module Net::HTTPHeader
    def capitalize(name)
        if (name.downcase == 'x-ipm-username')
            return 'X-IPM-Username'
        elsif (name.downcase == 'x-ipm-password')
            return 'X-IPM-Password'
        else
            return name.to_s.split(/-/).map {|s| s.capitalize }.join('-')
        end
    end

    private :capitalize
end

module SOLIDserver
  class SOLIDserverError < StandardError
  end

  class SOLIDserver
    @url = ''
    @timeout  = 8
    @sslcheck = false
    @username = ''
    @password = ''
    @servicemapper = {}

    # Inspector (Hide Sensitive Information)
    def inspect()
      '#<#{self.class}:#{object_id} @url=\'#{@resturl}\' @sslcheck=#{@sslcheck} @timeout=#{@timeout}>'
    end

    # Constructor (Build the instance)
    # Requires :
    #   host : Targeted Host IP addresse or FQDN
    #   username : Username used to access the service
    #   password : Username associated password
    #   port : Listening http port (default 443)
    #   sslcheck : Verify SSL certificat (default false)
    #   timeout  : HTTP query timeout (default 8)
    def initialize(host, username, password, port=443, sslcheck=false, timeout=8)
      @resturl  = sprintf('https://%s:%d/rest', host, port)
      @rpcurl   = sprintf('https://%s:%d/rpc', host, port)
      @timeout  = timeout
      @sslcheck = sslcheck
      @username = Base64.strict_encode64(username)
      @password = Base64.strict_encode64(password)

      # Map the new naming convention against the old one
      #FIXME# Filtering json hash content can be done this way
      # h1 = {:a => 1, :b => 2, :c => 3, :d => 4}
      # h1.slice(:a, :b)         # return {:a=>1, :b=>2}, but h1 is not changed
      # h2 = h1.slice!(:a, :b)   # h1 = {:a=>1, :b=>2}, h2 = {:c => 3, :d => 4}
      @servicemapper = {
        'ip_site_add' => ['ip_site_add', 'This service allows to add an IP address Space.'],
        'ip_site_update' => ['ip_site_add', 'This service allows to update an IP address Space.'],
        'ip_site_count' => ['ip_site_count', 'This service returns the number of IP address Spaces matching optional condition(s).'],
        'ip_site_list' => ['ip_site_list', 'This service returns a list of IP address Spaces matching optional condition(s).'],
        'ip_site_info' => ['ip_site_info', 'This service returns information about a specific IP address Space.'],
        'ip_site_delete' => ['ip_site_delete', 'This service allows to delete a specific IP address Space.'],
        'ip_subnet_add' => ['ip_subnet_add', 'This service allows to add an IPv4 Network of type Subnet or Block.'],
        'ip_subnet_update' => ['ip_subnet_add', 'This service allows to update an IPv4 Network of type Subnet or Block.'],
        'ip_subnet_count' => ['ip_block_subnet_count', 'This service returns the number of IPv4 Networks matching optional condition(s).'],
        'ip_subnet_list' => ['ip_block_subnet_list', 'This service returns a list of IPv4 Networks matching optional condition(s).'],
        'ip_subnet_info' => ['ip_block_subnet_info', 'This service returns information about a specific IPv4 Network.'],
        'ip_subnet_delete' => ['ip_subnet_delete', 'This service allows to delete a specific IPv4 Network.'],
        'ip_subnet_find_free' => ['ip_find_free_subnet', 'This service allows to retrieve a list of available IPv4 Networks matching optional condition(s).'],
        'ip_subnet6_add' => ['ip6_subnet6_add', 'This service allows to add an IPv6 Network of type Subnet or Block.'],
        'ip_subnet6_update' => ['ip6_subnet6_add', 'This service allows to update an IPv6 Network of type Subnet or Block.'],
        'ip_subnet6_count' => ['ip6_block6_subnet6_count', 'This service returns the number of IPv6 Networks matching optional condition(s).'],
        'ip_subnet6_list' => ['ip6_block6_subnet6_list', 'This service returns a list of IPv6 Networks matching optional condition(s).'],
        'ip_subnet6_info' => ['ip6_block6_subnet6_info', 'This service returns information about a specific IPv6 Network.'],
        'ip_subnet6_delete' => ['ip6_subnet6_delete', 'This service allows to delete a specific IPv6 Network.'],
        'ip_subnet6_find_free' => ['ip6_find_free_subnet6', 'This service allows to retrieve a list of available IPv6 Networks matching optional condition(s).'],
        'ip_pool_add' => ['ip_pool_add', 'This service allows to add an IPv4 Address Pool.'],
        'ip_pool_update' => ['ip_pool_add', 'This service allows to update an IPv4 Address Pool.'],
        'ip_pool_count' => ['ip_pool_count', 'This service returns the number of IPv4 Address Pools matching optional condition(s).'],
        'ip_pool_list' => ['ip_pool_list', 'This service returns a list of IPv4 Address Pools matching optional condition(s).'],
        'ip_pool_info' => ['ip_pool_info', 'This service returns information about a specific IPv4 Address Pool.'],
        'ip_pool_delete' => ['ip_pool_delete', 'This service allows to delete a specific IPv4 Address Pool.'],
        'ip_pool6_add' => ['ip6_pool6_add', 'This service allows to add an IPv6 Address Pool.'],
        'ip_pool6_update' => ['ip6_pool6_add', 'This service allows to update an IPv6 Address Pool.'],
        'ip_pool6_count' => ['ip6_pool6_count', 'This service returns the number of IPv6 Address Pools matching optional condition(s).'],
        'ip_pool6_list' => ['ip6_pool6_list', 'This service returns a list of IPv6 Address Pools matching optional condition(s).'],
        'ip_pool6_info' => ['ip6_pool6_info', 'This service returns information about a specific IPv6 Address Pool.'],
        'ip_pool6_delete' => ['ip6_pool6_delete', 'This service allows to delete a specific IPv6 Address Pool.'],
        'ip_address_add' => ['ip_add', 'This service allows to add an IPv4 Address.'],
        'ip_address_update' => ['ip_add', 'This service allows to update an IPv4 Address.'],
        'ip_address_count' => ['ip_address_count', 'This service returns the number of IPv4 Addresses matching optional condition(s).'],
        'ip_address_list' => ['ip_address_list', 'This service returns a list of IPv4 Addresses matching optional condition(s).'],
        'ip_address_info' => ['ip_address_info', 'This service returns information about a specific IPv4 Address.'],
        'ip_address_delete' => ['ip_delete', 'This service allows to delete a specific IPv4 Address.'],
        'ip_address_find_free' => ['ip_find_free_address', 'This service allows to retrieve a list of available IPv4 Addresses matching optional condition(s).'],
        'ip_address6_add' => ['ip6_address6_add', 'This service allows to add an IPv6 Address'],
        'ip_address6_update' => ['ip6_address6_add', 'This service allows to update an IPv6 Address'],
        'ip_address6_count' => ['ip6_address6_count', 'This service returns the number of IPv6 Addresses matching optional condition(s).'],
        'ip_address6_list' => ['ip6_address6_list', 'This service returns a list of IPv6 Addresses matching optional condition(s).'],
        'ip_address6_info' => ['ip6_address6_info', 'This service returns information about a specific IPv6 Address.'],
        'ip_address6_delete' => ['ip6_address6_delete', 'This service allows to delete a specific IPv6 Address.'],
        'ip_address6_find_free' => ['ip6_find_free_address6', 'This service allows to retrieve a list of available IPv6 Addresses matching optional condition(s).'],
        'ip_alias_add' => ['ip_alias_add', 'This service allows to associate an Alias of type A or CNAME to an IPv4 Address.'],
        'ip_alias_list' => ['ip_alias_list', 'This service returns the list of an IPv4 Address\' associated Aliases.'],
        'ip_alias_delete' => ['ip_alias_delete', 'This service allows to remove an Alias associated to an IPv4 Address.'],
        'ip_alias6_add' => ['ip6_alias_add', 'This service allows to associate an Alias of type A or CNAME to an IPv4 Address.'],
        'ip_alias6_list' => ['ip6_alias_list', 'This service returns the list of an IPv6 Address\' associated Aliases.'],
        'ip_alias6_delete' => ['ip6_alias_delete', 'This service allows to remove an Alias associated to an IPv6 Address.'],
        'vlm_domain_add' => ['vlm_domain_add', 'This service allows to add a VLAN Domain.'],
        'vlm_domain_update' => ['vlm_domain_add', 'This service allows to update a VLAN Domain.'],
        'vlm_domain_count' => ['vlmdomain_count', 'This service returns the number of VLAN Domains matching optional condition(s).'],
        'vlm_domain_list' => ['vlmdomain_list', 'This service returns a list of VLAN Domains matching optional condition(s).'],
        'vlm_domain_info' => ['vlmdomain_info', 'This service returns information about a specific VLAN Domain.'],
        'vlm_domain_delete' => ['vlm_domain_delete', 'This service allows to delete a specific VLAN Domain.'],
        'vlm_range_add' => ['vlm_range_add', 'This service allows to add a VLAN Range.'],
        'vlm_range_update' => ['vlm_range_add', 'This service allows to update a VLAN Range.'],
        'vlm_range_count' => ['vlmrange_count', 'This service returns the number of VLAN Ranges matching optional condition(s).'],
        'vlm_range_list' => ['vlmrange_list', 'This service returns a list of VLAN Domains matching optional condition(s).'],
        'vlm_range_info' => ['vlmrange_info', 'This service returns information about a specific VLAN Range.'],
        'vlm_range_delete' => ['vlm_range_delete', 'This service allows to delete a specific VLAN Range.'],
        'vlm_vlan_add' => ['vlm_vlan_add', 'This service allows to add a VLAN.'],
        'vlm_vlan_update' => ['vlm_vlan_add', 'This service allows to update a VLAN.'],
        'vlm_vlan_count' => ['vlmvlan_count', 'This service returns the number of VLANs matching optional condition(s).'],
        'vlm_vlan_list' => ['vlmvlan_list', 'This service returns a list of VLANs matching optional condition(s).'],
        'vlm_vlan_info' => ['vlmvlan_info', 'This service returns information about a specific VLAN.'],
        'vlm_vlan_delete' => ['vlm_vlan_delete', 'This service allows to delete a specific VLAN.']
      }
    end

    # Documentation Generator
    # Requires :
    def doc()
      buffer = ''
      descr_mapping = {}

      buffer += '## Available Methods :\n\n'
      buffer += 'This GEM wraps the following SOLIDserver API calls, allowing you to interract with SOLIDserver DDI solution.\n'

      begin
        @servicemapper.each do |service_name, service_mapped|
          buffer += '\n### Method - #{service_name}\n'
          rest_answer = RestClient::Request.execute(
            url: sprintf('%s/%s', @resturl, service_mapped[0]),
            accept: 'application/json',
            method: 'options',
            timeout: @timeout,
            verify_ssl: @sslcheck,
            headers: {
              'X-IPM-Username' => @username,
              'X-IPM-Password' => @password
            }
          )

          first_input = true
          first_output = true

          JSON.parse(rest_answer.body).each do |item|
            if (item.has_key?('description'))
              buffer += 'Description\n\n'
              buffer += '\t#{@servicemapper[service_name.to_s][1]}\n'
            end

            if (item.has_key?('mandatory_addition_params') && service_name.match(/_add$/))
              buffer += '\nMandatory Parameters\n\n'
              buffer += '\t' + item['mandatory_addition_params'].gsub('&&', '+').gsub('||','|') + '\n'
            end

            if (item.has_key?('mandatory_edition_params')  && service_name.match(/_update$/))
              buffer += '\nMandatory Parameters\n\n'
              buffer += '\t' + item['mandatory_edition_params'].gsub('&&', '+').gsub('||','|') + '\n'
            end

            if (item.has_key?('mandatory_params'))
              buffer += '\nMandatory Parameters\n\n'
              buffer += '\t' + item['mandatory_params'].gsub('&&', '+').gsub('||','|') + '\n'
            end

            if (item.has_key?('param_type'))
              if (item['param_type'] == 'in')
                if (first_input == true)
                  buffer += '\nAvailable Input Parameters :\n\n'
                  first_input = false
                end

                if (item['name'] == 'WHERE')
                  buffer += '\t* where - Can be used to filter the result using any output field in an SQL fashion.\n'
                elsif (item['name'] == 'ORDERBY')
                  buffer += '\t* orderby - Can be used to order the result using any output field in an SQL fashion.\n'
                else
                  descr_key = service_name[/^(ip|vlm|dns)/]
                  if (item.has_key?('descr'))
                    descr_mapping[descr_key.to_s + '_' + item['name']] = item['descr']
                  end
                  if !(item.has_key?('descr') && item['name'].match(/^no_usertracking/))
                    buffer += '\t* ' + item['name'] + (item.has_key?('descr') ? ' - ' +  item['descr'] : '') + '\n'
                  end
                end
              else
                if (first_output == true)
                  buffer += '\nAvailable Output Fields :\n\n'
                  first_output = false
                end

                descr_key = service_name[/^(ip|vlm|dns)/]

                if (item.has_key?('descr'))
                  descr_mapping[descr_key.to_s + '_' + item['name']] = item['descr']
                else
                  if (descr_mapping.has_key?(descr_key.to_s + '_' + item['name']))
                    item['descr'] = descr_mapping[descr_key + '_' + item['name']]
                  end
                end
                buffer += '\t* ' + item['name'] + (item.has_key?('descr') ? ' - ' + item['descr'] : '') + '\n'
              end
            end
          end
        end

        return(buffer)
      rescue RestClient::ExceptionWithResponse => rest_error
        raise SOLIDserverError.new('SOLIDserver REST call error : - TEST')
      end
    end


    # Generic REST call used to metaprogram all SOLIDserver available webservices
    # Requires :
    #   rest_method : HTTP verb called
    #   rest_service : API web service called
    #   args : array containing web service parameter within hashes
    # Programming Tips :
    #   * https://www.toptal.com/ruby/ruby-metaprogramming-cooler-than-it-sounds
    def call(rest_method, rest_service, args={})
      rest_args = ''

      args.each do |arg|
        args[0].each do |key, value|
          if (key.to_s == 'where' || key.to_s == 'orderby')
            key = key.to_s.upcase()
          end

          rest_args += key.to_s + '=' + ERB::Util.url_encode(value.to_s) + '&'
        end
      end

      begin
        rest_answer = RestClient::Request.execute(
          url: sprintf('%s/%s?', (rest_service.match(/find_free/) ? @rpcurl : @resturl), rest_service) + rest_args,
          accept: 'application/json',
          method: rest_method,
          timeout: @timeout,
          verify_ssl: @sslcheck,
          headers: {
            'X-IPM-Username' => @username,
            'X-IPM-Password' => @password
          }
        )

        return(rest_answer)
      rescue RestClient::ExceptionWithResponse => rest_error
        raise SOLIDserverError.new("SOLIDserver REST call error : #{rest_error.message}")
      end
    end

    # Generic Method Wrapper
    # Requires :
    #   method : called method name
    #   args : called method arguments
    def method_missing(method, *args)
      if (service =  method.to_s.match(/^(ip|vlm|dns)_(site|subnet6?|pool6?|address6?|alias6?|domain|range|vlan|server|view|zone|rr)_(add|update|info|list|delete|count)$/))
        r_module, r_object, r_action = service.captures

        if (@servicemapper.has_key?(service.to_s))
          r_mapped_service = @servicemapper[service.to_s][0]
        end

        # case r_action with add, update, list, delete, count to set r_method
        case r_action
        when 'add'
          r_method = 'post'
        when 'update'
          r_method = 'put'
        when 'delete'
          r_method = 'delete'
        else
          r_method = 'get'
        end

        self.call(r_method, r_mapped_service, args)
      else
        super
      end
    end
  end
end
