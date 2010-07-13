Plugin.define "asnmx" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
  
	def init
#	    require 'dnsruby'
#			@dnsruby = Dnsruby::Resolver.new
#			@resolver = Dnsruby::DNS.open
	end

	def getasn(addr)
		IPTOOLS.getasn(addr)
	end

	def process(map)
		flag = false
		if map['request'] == "smtpd_access_policy"
			clientasn = getasn(map['client_address'])
			pp clientasn
#			user , domain = map['sender'].split('@')
#			@resolver.getresources(domain,'MX').collect do |resource|
#				@resolver.getresources(resource.exchange.to_s,'A').collect do |raddr|
#					if getasn(raddr.address.to_s) == clientasn
#						flag = true
#					end
#				end
#			end
		end
		if flag
			action="DEFER_IF_PERMIT Greylist indicada pelo sistema antispam (PHASE-0 ASNMX)" unless Greylist.instance.check(map)
		end
	end


end
