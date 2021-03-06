Gem::Specification.new do |s|
  s.name = 'alexa_modelmd'
  s.version = '0.3.6'
  s.summary = 'Using a WikiMd formatted document, generates a basic Amazon ' + 
              'Alexa model in XML format, as well as other formats.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/alexa_modelmd.rb']
  s.add_runtime_dependency('wiki_md', '~> 0.7', '>=0.7.8')
  s.signing_key = '../privatekeys/alexa_modelmd.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/alexa_modelmd'
end
