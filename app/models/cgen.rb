require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false


class Cgen
	include Capybara::DSL
	#def extract(url)
		#doc = Nokogiri::HTML(open(url))
		#p doc.at_css("title")
		#p doc.css("#reviews-container div")
		#doc.xpath("//*[contains(concat( \" \", @class, \" \" ), concat( \" \", \"hidden\", \" \" ))]")
		#"//*[contains(concat( \" \", @class, \" \" ), concat( \" \", \"rev-text\", \" \" ))]"
	#end

	def get_zomato_results(url)
		visit(url)
	  doc = Nokogiri::HTML(page.html)
	  results = doc.css(".result-title")

	  if results.present?
	  	results.each do |result|
	  		name = result.text
	  		href = result["href"]
	  		p name
	  		p href
	  		#get_page_data(href)
	  	end
	  end
	  #p doc
	  #reviews = doc.css('.rev-text')
	  #if reviews.present?
	  #	reviews.each do |review|
	  #		p review.text.strip
	  #		p "****************"
	  #	end
	  #end	  
	end

	def get_page_data(url)
	  visit(url)
	  doc = Nokogiri::HTML(page.html)
	  #p doc
	  #reviews = doc.css('.rev-text')
	  #if reviews.present?
	  #	reviews.each do |review|
	  #		p review.text.strip
	  #		p "****************"
	  #	end
	  #end
	  data_id = doc.css("div").select{|d| d['data-res_id'].present?}.first["data-res_id"]
	  p data_id
	  images = doc.css('.res-photo-thumbnail')
	  #p images
	  if images.present?
	  	images.each do |image|
	  		p image["src"]
	  		p "****************"
	  	end
	  end
	end

	#scraper = Cgen.new
	#puts scraper.get_page_data('https://www.zomato.com/bangalore/dishoom-domlur/reviews#tabtop').map(&:text).inspect
	#visit(https://www.zomato.com/bangalore/dishoom-domlur/reviews#tabtop)
	#scraper.get_zomato_results('https://www.zomato.com/bangalore/jp-nagar-restaurants/italian')
end