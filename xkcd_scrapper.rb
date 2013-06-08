require 'mechanize'
require 'open-uri'

URL = 'http://www.xkcd.com/archive'

# Initialize and grab URL
agent = Mechanize.new     # New Mechanize object
archive = agent.get(URL)  # Mechanize objects gets XKCD url
cname  = Array.new        # Creating new array for comic name
cnumber = Array.new       # Creating new array for comic number

# get XPath to comic number
archive.search('//div[@id="middleContainer"]/a/@href').each do |path|
 cnumber << path.text 
end

# get XPath to comic name/title
archive.search('//div[@id="middleContainer"]/a').each do |path|
 cname << path.text
end

cnumber.each do |l|
 agent.get("http://www.xkcd.com/#{l}").search('//*[@id="comic"]/img').each do |src|
  path = src.attributes['src']
  
  agent.get(path).save
 end
end
