module Jekyll
  class ReverbnationGenerator < Generator
    
    def generate(site)
      require 'nokogiri'
      require 'open-uri'
      require 'date'
    
      doc = Nokogiri::XML(open('http://www.reverbnation.com/rss/artist_shows_rss/' + Jekyll.configuration({})['reverbnation'], 'User-Agent' => 'ruby'))
      search = doc.css('item')
      reverbnation = []
      if !search.empty?
        search.each do |item|
          data = Hash.new
          data['date'] = DateTime.parse(item.at('title').text)
          data['venue'] = item.at('venue').text
          data['location'] = item.at('loc').text
          reverbnation.push(data)
        end
      end
      
      site.data['reverbnation'] = reverbnation
    end
  end
end
