module Jekyll
  class YoutubeGenerator < Generator
    
    def generate(site)
      require 'nokogiri'
      require 'open-uri'
      require 'date'
    
      doc = Nokogiri::XML(open('http://gdata.youtube.com/feeds/api/users/' + Jekyll.configuration({})['youtube'] + '/uploads', 'User-Agent' => 'ruby'))
      doc.remove_namespaces!
      search = doc.css('entry')
      youtube = []
      if !search.empty?
        search.each do |item|
          data = Hash.new
          data['id'] = item.at('id').text.split("/").last
          data['link'] = "http://youtu.be/" + data['id']
          data['title'] = item.at('title').text
          data['description'] = item.at('description').text.gsub(/(?:\n\r?|\r\n?)/, '<br>')
          data['thumbnail'] = 'http://i.ytimg.com/vi/' + data['id'] + '/0.jpg'
          data['duration'] = Time.at(item.at('duration/@seconds').text.to_i).gmtime.strftime('%R:%S')
          data['embed'] = '<div class="videoWrapper"><iframe width="560" height="349" src="http://www.youtube-nocookie.com/embed/' + data['id'] + '" frameborder="0" allowfullscreen></iframe></div>'
        

          youtube.push(data)
        end
      end

      site.data['youtube'] = youtube
    end
  end
end
