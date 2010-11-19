#require 'nokogiri'

def validate_owl(uri)
  if validator_available?
    owl = OpenTox::RestClientWrapper.get(uri,:accept => "application/rdf+xml")
    html = OpenTox::RestClientWrapper.post("http://www.mygrid.org.uk/OWL/Validator",{:rdf => owl, :level => "DL"})
    assert_match(/YES/,html)
  else
    puts "http://www.mygrid.org.uk/OWL/Validator offline"
  end
end

def validator_available?
  uri = URI.parse "http://www.mygrid.org.uk/OWL/Validator"
  Net::HTTP.start(uri.host, uri.port) do |http| 
    begin
      http.read_timeout = 5
      http.head(uri.path).code == '200' 
    rescue Timeout::Error
      false
    end
  end
end
