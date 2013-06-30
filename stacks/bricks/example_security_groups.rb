#
# Define the default *ingress* security rules. Your office IPs and VPN IPs need to be in here
#
def globals.example_security_group_ingress
  # Define VPC vs. non-vpc security groups differently
  if self.respond_to?('no_vpc') && self.no_vpc
    protocols = [ "tcp", "udp", "icmp" ]
    from_port = "-1"
    to_port = "-1"
  else
    protocols = [ "-1" ]
    from_port = "0"
    to_port = "65535"
  end
  
  rules = []
  protocols.each do |protocol|
    case protocol
    when "tcp"
      from_port = "0"
      to_port = "65535"
    when "udp"
      from_port = "0"
      to_port = "65535"
    when "icmp"
      from_port = "-1"
      to_port = "-1"
    when "-1"
      from_port = "0"
      to_port = "65535"
    else
      # error ?
    end
    
    rules += [
      # Main office IP
      { :ip_protocol => protocol, :from_port => from_port, :to_port => to_port, :cidr_ip => "123.123.123.123/32", },
    ]
  end
  
  rules
end
