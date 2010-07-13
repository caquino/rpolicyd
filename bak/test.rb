  require 'resolv'
	require 'pp'
	                 @resolver = Resolv::DNS.new

	def getasn(addr)
    revaddr = addr.split('.').reverse.join('.')
    @resolver.getresource("#{revaddr}.asn.routeviews.org",Resolv::DNS::Resource::IN::TXT).data.to_s
  end

clientasn = getasn('200.230.123.82')
			pp clientasn
      @resolver.getresources('caquino@ebrain.com.br'.split('@')[1],Resolv::DNS::Resource::IN::MX).collect {|exchange|
				pp exchange.exchange.to_s
				@resolver.getresources(exchange.exchange.to_s, Resolv::DNS::Resource::IN::A).collect {|addr|
					pp addr.address.to_s
					pp getasn(addr.address.to_s)
				}
			}
