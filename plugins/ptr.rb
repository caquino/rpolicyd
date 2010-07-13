Plugin.define "ptr" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
	
	def init()
	end

	def finalize()
	end
  
	def process(map)
		if map['request'] == "smtpd_access_policy"
			if map['client_name'] == 'unknown'
				action="DEFER_IF_PERMIT Greylist indicada pelo sistema antispam (PHASE-0 REV)" unless Greylist.instance.check(map)
			end
		end
	end

end
