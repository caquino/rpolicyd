Plugin.define "geoip" do

  author "Cassiano Aquino"
  version "1.0.0"
	type "action"
  
	def init
	end

	def process(map)
		if map['request'] == "smtpd_access_policy"
			country = GeoIP.instance.check(map)
			if country == 'JP' or country == 'CN' or country == 'KR'
				action="DEFER_IF_PERMIT Greylist indicada pelo sistema antispam (PHASE-0 GIP)" unless Greylist.instance.check(map)
			end
		end
	end

	def terminate
		@g.close()
	end

end
