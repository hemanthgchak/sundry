class Twt
	def initialize
		config = {
		  consumer_key:    "",
		  consumer_secret: "",
		}	

		@client = Twitter::REST::Client.new(config)	
	end

	def search(param)
		@client.search(param)
	end
end

