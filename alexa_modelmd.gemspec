Gem::Specification.new do |s|
  s.name = 'alexa_modelmd'
  s.version = '0.1.1'
  s.summary = 'Using a WikiMd foramtted document, generates a basic Amazon ' + 
              'Alexa model in XML format, as well as other formats ... soon.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/alexa_modelmd.rb']
  s.add_runtime_dependency('wikimd', '~> 0.4', '>=0.4.2')
  s.signing_key = '../privatekeys/alexa_modelmd.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/alexa_modelmd'
end
