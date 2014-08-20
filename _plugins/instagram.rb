module Jekyll
  class InstagramGenerator < Generator
    
    def generate(site)
      require 'nokogiri'
      require 'open-uri'
    
      doc = Nokogiri::HTML(open('http://instagrss-mgng.rhcloud.com/' + Jekyll.configuration({})['instagram'], 'User-Agent' => 'ruby'))
      search = doc.css('item')
      instagram = []
      if !search.empty?
        search.each do |item|
        #desc = Nokogiri::HTML(item.at('description')).at('img')
       # puts desc
          data = Hash.new
          data['link'] = item.at('link').next_sibling.text.strip![0..-2]
          data['id'] = data['link'].split('/').last
          data['title'] = item.at('title').text
          data['image'] = 'http://instagr.am/p/' + data['id'] + '/media/?size=l'

          instagram.push(data)
        end
      end

      site.data['instagram'] = instagram
    end
  end
end
