Plugin.define "helo" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
  
	def init
	end

	def process(map)
		if map['request'] == "smtpd_access_policy"
			if map['helo_name'].split('.').length == 1
				action="REJECT Rejeitado pelo sistema antispam (PHASE-1 1)"
			end

			if map['helo_name'] == map['recipient'].split('@')[1]
				action="REJECT Rejeitado pelo sistema antispam (PHASE-1 2)"
			end
			if IPTOOLS.IPv4(map['helo_name']).valid?
				if map['helo_name'] != map['client_address']
					action="REJECT Rejeitado pelo sistema antispam (PHASE-1 3)"
				end
			end
		end
	end

end
