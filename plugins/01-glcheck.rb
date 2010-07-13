Plugin.define "glcheck" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
	
	def init()
	end

	def finalize()
	end
  
	def process(map)
		if map['request'] == "smtpd_access_policy"
			action="DEFER_IF_PERMIT Greylist solicitada pelo sistema antispam(PHASE-0 STATEFUL)" unless Greylist.instance.phase1(map)
		end
		action
	end

end
