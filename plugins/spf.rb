Plugin.define "spf" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
  
	def init
		require 'ipaddr'
	end

	def process(map)
		if map['request'] == "smtpd_access_policy"
			pp SPFCheck.instance.check(map)
				if SPFCheck.instance.check(map) == SPF::SPF_RESULT_FAIL
					action="REJECT Rejeitado pelo sistema antispam (PHASE-1 SPFH)"
				elsif SPFCheck.instance.check(map) == SPF::SPF_RESULT_SOFTFAIL and Greylist.instance.check(map)
					action="DEFER_IF_PERMIT Greylist indicada pelo sistema antispam (PHASE-1 SPFS)" 
				end
		end
		action
	end

end
