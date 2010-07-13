Plugin.define "ipthrottle" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
	
	def init()
	end

	def finalize()
	end
  
	def process(map)
		if map['request'] == "smtpd_access_policy"
			action="DEFER_IF_PERMIT Suspensao de envio solicitada pelo sistema antispam (PHASE-0 RIP)" unless RELAYD.check_ip(map["client_address"])
			action="DEFER_IF_PERMIT Suspensao de envio solicitada pelo sistema antispam (PHASE-1 RIP)" unless RELAYD.check_user(map["sasl_username"])
		end
		if map["sasl_username"]
			RELAYD.ack(map["sasl_username"],map["client_address"])
		else
			RELAYD.ack("",map["client_address"])
		end
		RELAYD.commit()
		action
	end

end
