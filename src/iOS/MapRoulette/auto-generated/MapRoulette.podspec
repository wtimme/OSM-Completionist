Pod::Spec.new do |s|
  s.name = 'MapRoulette'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.version = '0.0.1'
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.authors = 'Swagger Codegen'
  s.license = 'ISC License'
  s.homepage = 'https://github.com/wtimme/osm-completionist'
  s.summary = 'Auto-generated API client for MapRoulette'
  s.source_files = 'MapRoulette/Classes/**/*.swift'
  s.dependency 'Alamofire', '~> 4.9.0'
end
