class Gsearch
	class << self
		@@embedly_api = Embedly::API.new :key => '',
        :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; hemanth.gc@strata.co.in)'

		def searchweb(query, offset = 0)
			search = Google::Search::Web.new(:query => query, :offset => offset, :tbs => "qdr:d")
			response = search.response
			response.items.each do |item|
				uri = item.uri
				p "Web URI is #{uri}"
				#obj = @@embedly_api.extract :url => uri				
				#p "Obj is #{obj}"
				#puts JSON.pretty_generate(obj[0].marshal_dump)
			end
		end

		def searchblog(query, offset = 0)
			search = Google::Search::Blog.new(:query => query, :offset => offset)
			response = search.response
			response.items.each do |item|
				uri = item.uri
				p "Blog URI is #{uri}"
				#obj = @@embedly_api.extract :url => uri				
				#p "Obj is #{obj}"
				#puts JSON.pretty_generate(obj[0].marshal_dump)
			end
		end

		def searchimage(query, offset = 0)
			search = Google::Search::Image.new(:query => query, :offset => offset)
			response = search.response
			response.items.each do |item|
				uri = item.uri
				p "Image URI is #{uri}"
				#obj = @@embedly_api.extract :url => uri				
				#p "Obj is #{obj}"
				#puts JSON.pretty_generate(obj[0].marshal_dump)
			end
		end

		def searchnews(query, offset = 0)
			search = Google::Search::News.new(:query => query, :offset => offset)
			response = search.response
			response.items.each do |item|
				uri = item.uri
				p "News URI is #{uri}"
				#obj = @@embedly_api.extract :url => uri				
				#p "Obj is #{obj}"
				#puts JSON.pretty_generate(obj[0].marshal_dump)
			end
		end

		def search(query, offset = 0)
			searchweb(query, offset)
			searchimage(query, offset)
			searchblog(query, offset)
			searchnews(query, offset)
		end
	end
end